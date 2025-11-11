import { useState, useEffect, useRef } from 'react';
import { Play, Pause, RotateCcw, Activity, Smartphone } from 'lucide-react';

interface StepCounterProps { }

export default function StepCounter({ }: StepCounterProps) {
    const [steps, setSteps] = useState<number>(0);
    const [isActive, setIsActive] = useState<boolean>(false);
    const [sessionSteps, setSessionSteps] = useState<number>(0);
    const [sensorSupported, setSensorSupported] = useState<boolean>(false);
    const [permissionGranted, setPermissionGranted] = useState<boolean>(false);
    const [needsPermission, setNeedsPermission] = useState<boolean>(false);

    const lastStepTimeRef = useRef<number>(0);
    const accelerationHistoryRef = useRef<number[]>([]);
    const baselineAccelerationRef = useRef<number>(9.8);
    const STEP_THRESHOLD = 2.5; // Higher threshold for detecting a step
    const MIN_STEP_INTERVAL = 400; // Minimum time between steps in ms (2.5 steps per second max)
    const BASELINE_UPDATE_RATE = 0.1; // Rate at which baseline updates to current conditions

    // Check if motion sensors are supported
    useEffect(() => {
        if (typeof DeviceMotionEvent !== 'undefined') {
            setSensorSupported(true);

            // Check if we need to request permission (iOS 13+)
            if (typeof (DeviceMotionEvent as any).requestPermission === 'function') {
                setNeedsPermission(true);
            } else {
                setPermissionGranted(true);
            }
        }
    }, []);

    // Load saved steps from localStorage on mount
    useEffect(() => {
        const savedSteps = localStorage.getItem('stepCounter_totalSteps');
        if (savedSteps) {
            setSteps(parseInt(savedSteps, 10));
        }
    }, []);

    // Save steps to localStorage whenever steps change
    useEffect(() => {
        localStorage.setItem('stepCounter_totalSteps', steps.toString());
    }, [steps]);

    // Request permission for iOS devices
    const requestMotionPermission = async () => {
        try {
            if (typeof (DeviceMotionEvent as any).requestPermission === 'function') {
                const response = await (DeviceMotionEvent as any).requestPermission();
                if (response === 'granted') {
                    setPermissionGranted(true);
                    setNeedsPermission(false);
                    return true;
                }
            }
            return false;
        } catch (error) {
            console.error('Error requesting motion permission:', error);
            return false;
        }
    };

    // Calculate magnitude of acceleration vector
    const calculateMagnitude = (x: number, y: number, z: number): number => {
        return Math.sqrt(x * x + y * y + z * z);
    };

    // Detect if current acceleration represents a step
    const detectStep = (magnitude: number): boolean => {
        const currentTime = Date.now();

        // Update baseline with moving average
        baselineAccelerationRef.current =
            baselineAccelerationRef.current * (1 - BASELINE_UPDATE_RATE) +
            magnitude * BASELINE_UPDATE_RATE;

        // Calculate deviation from baseline
        const deviation = Math.abs(magnitude - baselineAccelerationRef.current);

        // Add to history (keep last 15 readings for better smoothing)
        accelerationHistoryRef.current.push(deviation);
        if (accelerationHistoryRef.current.length > 15) {
            accelerationHistoryRef.current.shift();
        }

        // Need at least 5 readings to detect peaks
        if (accelerationHistoryRef.current.length < 5) {
            return false;
        }

        // Check if enough time has passed since last step
        if (currentTime - lastStepTimeRef.current < MIN_STEP_INTERVAL) {
            return false;
        }

        // Advanced peak detection with multiple conditions
        const history = accelerationHistoryRef.current;
        const currentIdx = history.length - 1;

        // Check if current value is a significant peak
        const isPeak = currentIdx >= 2 &&
            deviation > STEP_THRESHOLD &&
            deviation > history[currentIdx - 1] &&
            deviation > history[currentIdx - 2];

        // Additional validation: ensure it's not just noise
        const recentAverage = history.slice(-5).reduce((a, b) => a + b, 0) / 5;
        const isSignificantMovement = deviation > recentAverage * 1.5;

        // Require both peak detection and significant movement
        if (isPeak && isSignificantMovement) {
            lastStepTimeRef.current = currentTime;
            return true;
        }

        return false;
    };

    // Set up motion sensor listener
    useEffect(() => {
        if (!isActive || !sensorSupported || !permissionGranted) {
            return;
        }

        const handleMotion = (event: DeviceMotionEvent) => {
            const acc = event.accelerationIncludingGravity;

            if (acc && acc.x !== null && acc.y !== null && acc.z !== null) {
                const x = acc.x || 0;
                const y = acc.y || 0;
                const z = acc.z || 0;

                // Calculate total magnitude including gravity
                const magnitude = calculateMagnitude(x, y, z);

                if (detectStep(magnitude)) {
                    setSteps(prev => prev + 1);
                    setSessionSteps(prev => prev + 1);
                }
            }
        };

        window.addEventListener('devicemotion', handleMotion);

        return () => {
            window.removeEventListener('devicemotion', handleMotion);
        };
    }, [isActive, sensorSupported, permissionGranted]);

    // Manual step input with spacebar
    useEffect(() => {
        const handleKeyPress = (event: KeyboardEvent) => {
            if (event.code === 'Space' && isActive) {
                event.preventDefault();
                addStep();
            }
        };

        document.addEventListener('keydown', handleKeyPress);

        return () => {
            document.removeEventListener('keydown', handleKeyPress);
        };
    }, [isActive]);

    const addStep = () => {
        setSteps(prev => prev + 1);
        setSessionSteps(prev => prev + 1);
    };

    const toggleTracking = async () => {
        if (!isActive && needsPermission && !permissionGranted) {
            const granted = await requestMotionPermission();
            if (!granted) {
                alert('Permissão para acessar sensores de movimento é necessária para contar passos automaticamente.');
                return;
            }
        }

        setIsActive(!isActive);
        if (!isActive) {
            setSessionSteps(0);
            accelerationHistoryRef.current = [];
            lastStepTimeRef.current = 0;
            baselineAccelerationRef.current = 9.8;
        }
    };

    const resetCounter = () => {
        setSteps(0);
        setSessionSteps(0);
        setIsActive(false);
        accelerationHistoryRef.current = [];
        lastStepTimeRef.current = 0;
        baselineAccelerationRef.current = 9.8;
        localStorage.removeItem('stepCounter_totalSteps');
    };

    const formatSteps = (stepCount: number) => {
        return stepCount.toLocaleString();
    };

    const getCaloriesBurned = (stepCount: number) => {
        // Rough estimate: 20 steps = 1 calorie
        return Math.round(stepCount / 20);
    };

    const getDistanceKm = (stepCount: number) => {
        // Rough estimate: 1300 steps = 1 km
        return (stepCount / 1300).toFixed(2);
    };

    return (
        <div className="min-h-screen bg-gradient-to-br from-blue-50 to-indigo-100 flex flex-col">
            {/* Header */}
            <div className="bg-white/80 backdrop-blur-sm shadow-sm">
                <div className="max-w-md mx-auto px-6 py-4">
                    <div className="flex items-center justify-center space-x-2">
                        <Activity className="w-6 h-6 text-indigo-600" />
                        <h1 className="text-xl font-bold text-gray-900">StepCounter</h1>
                    </div>
                </div>
            </div>

            {/* Main Content */}
            <div className="flex-1 flex flex-col justify-center items-center px-6 py-8">
                <div className="max-w-md w-full">

                    {/* Sensor Status Banner */}
                    {!sensorSupported && (
                        <div className="mb-6 bg-yellow-50 border border-yellow-200 rounded-xl p-4">
                            <div className="flex items-start space-x-3">
                                <Smartphone className="w-5 h-5 text-yellow-600 flex-shrink-0 mt-0.5" />
                                <div>
                                    <p className="text-sm font-medium text-yellow-800">Sensores não disponíveis</p>
                                    <p className="text-xs text-yellow-700 mt-1">
                                        Este dispositivo não suporta sensores de movimento. Abra este app em um smartphone.
                                    </p>
                                </div>
                            </div>
                        </div>
                    )}

                    {sensorSupported && (
                        <div className="mb-6 bg-green-50 border border-green-200 rounded-xl p-4">
                            <div className="flex items-start space-x-3">
                                <Smartphone className="w-5 h-5 text-green-600 flex-shrink-0 mt-0.5" />
                                <div>
                                    <p className="text-sm font-medium text-green-800">Detecção automática ativa</p>
                                    <p className="text-xs text-green-700 mt-1">
                                        Os passos serão contados automaticamente usando o acelerômetro do seu celular.
                                    </p>
                                </div>
                            </div>
                        </div>
                    )}

                    {/* Step Counter Display */}
                    <div className="bg-white rounded-3xl shadow-xl p-8 mb-8 text-center">
                        <div className="mb-4">
                            <p className="text-sm font-medium text-gray-500 mb-2">Total de Passos</p>
                            <div className="text-6xl font-bold text-indigo-600 mb-2 tabular-nums">
                                {formatSteps(steps)}
                            </div>
                            {isActive && (
                                <div className="flex items-center justify-center space-x-2">
                                    <div className="w-2 h-2 bg-green-500 rounded-full animate-pulse"></div>
                                    <p className="text-sm font-medium text-green-600">Contando...</p>
                                </div>
                            )}
                        </div>

                        {/* Session Stats */}
                        {sessionSteps > 0 && (
                            <div className="border-t pt-4">
                                <p className="text-xs text-gray-500 mb-2">Sessão Atual</p>
                                <p className="text-2xl font-bold text-gray-800">{formatSteps(sessionSteps)}</p>
                            </div>
                        )}
                    </div>

                    {/* Stats Cards */}
                    <div className="grid grid-cols-2 gap-4 mb-8">
                        <div className="bg-white/70 backdrop-blur-sm rounded-xl p-4 text-center">
                            <div className="text-2xl font-bold text-orange-600">{getCaloriesBurned(steps)}</div>
                            <div className="text-xs text-gray-600">Calorias</div>
                        </div>
                        <div className="bg-white/70 backdrop-blur-sm rounded-xl p-4 text-center">
                            <div className="text-2xl font-bold text-green-600">{getDistanceKm(steps)}</div>
                            <div className="text-xs text-gray-600">Km</div>
                        </div>
                    </div>

                    {/* Control Buttons */}
                    <div className="space-y-4">
                        <button
                            onClick={toggleTracking}
                            disabled={!sensorSupported}
                            className={`w-full py-4 px-6 rounded-2xl font-semibold text-lg transition-all duration-300 flex items-center justify-center space-x-3 ${!sensorSupported
                                    ? 'bg-gray-300 text-gray-500 cursor-not-allowed'
                                    : isActive
                                        ? 'bg-red-500 hover:bg-red-600 text-white shadow-lg hover:shadow-xl'
                                        : 'bg-indigo-600 hover:bg-indigo-700 text-white shadow-lg hover:shadow-xl'
                                }`}
                        >
                            {isActive ? (
                                <>
                                    <Pause className="w-6 h-6" />
                                    <span>Parar Contagem</span>
                                </>
                            ) : (
                                <>
                                    <Play className="w-6 h-6" />
                                    <span>Iniciar Contagem</span>
                                </>
                            )}
                        </button>

                        <button
                            onClick={resetCounter}
                            className="w-full py-3 px-6 rounded-2xl font-medium text-gray-700 bg-white/70 hover:bg-white transition-all duration-300 flex items-center justify-center space-x-2 shadow-md hover:shadow-lg"
                        >
                            <RotateCcw className="w-5 h-5" />
                            <span>Resetar Contador</span>
                        </button>
                    </div>

                    {/* Instructions */}
                    <div className="mt-8 text-center">
                        <p className="text-sm text-gray-600 leading-relaxed">
                            {!sensorSupported ? (
                                "Abra este app em um smartphone para usar a detecção automática de passos"
                            ) : isActive ? (
                                "Caminhe com o celular no bolso ou na mão. Os passos serão contados automaticamente."
                            ) : (
                                "Clique em 'Iniciar Contagem' e comece a caminhar com o celular"
                            )}
                        </p>
                    </div>
                </div>
            </div>
        </div>
    );
}
