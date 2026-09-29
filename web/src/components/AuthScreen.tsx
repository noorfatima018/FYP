"use client";

import { useState } from "react";

interface AuthScreenProps {
  initialMode?: "signin" | "signup";
}

export default function AuthScreen({ initialMode = "signin" }: AuthScreenProps) {
  const [mode, setMode] = useState<"signin" | "signup">(initialMode);
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [confirmPassword, setConfirmPassword] = useState("");
  const [showPassword, setShowPassword] = useState(false);
  const [showConfirmPassword, setShowConfirmPassword] = useState(false);
  const [focusedInput, setFocusedInput] = useState<string | null>(null);
  const [isLoading, setIsLoading] = useState(false);
  const [errorMessage, setErrorMessage] = useState("");
  const [successMessage, setSuccessMessage] = useState("");

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    setErrorMessage("");
    setSuccessMessage("");

    if (!email || !password) {
      setErrorMessage("Please enter both email and password.");
      return;
    }

    if (mode === "signup" && password !== confirmPassword) {
      setErrorMessage("Passwords do not match. Please check and try again.");
      return;
    }

    setIsLoading(true);
    setTimeout(() => {
      setIsLoading(false);
      if (mode === "signin") {
        setSuccessMessage("Signed in successfully! Welcome back.");
      } else {
        setSuccessMessage("Account created successfully! Welcome to RentWise.");
      }
    }, 1200);
  };

  return (
    <div className="min-h-screen w-full bg-white flex flex-col lg:flex-row font-sans text-[#0A2947] antialiased overflow-x-hidden">
      
      {/* MOBILE ONLY TOP VIDEO SECTION */}
      <div className="block lg:hidden bg-[#EFE6D5] p-6 rounded-b-[2.5rem] relative overflow-hidden">
        <div className="relative z-10 max-w-sm mx-auto flex items-center justify-center">
          <video
            autoPlay
            loop
            muted
            playsInline
            className="w-full h-auto max-h-56 object-contain mix-blend-multiply"
          >
            <source src="/animate_my_logo.webm" type="video/webm" />
            <source src="/animate_my_logo.mp4" type="video/mp4" />
          </video>
        </div>
      </div>


      {/* LEFT SIDE: Authentication Form */}
      <div className="w-full lg:w-[48%] xl:w-[45%] min-h-screen bg-white p-6 sm:p-12 lg:p-16 flex flex-col justify-between relative z-10">
        
        {/* Main Form Center Box */}
        <div className="w-full max-w-[420px] mx-auto my-auto py-6">
          
          {/* Headline */}
          <h1 className="text-3xl sm:text-[2.25rem] font-bold text-[#0A2947] tracking-tight mb-7 text-left leading-tight">
            {mode === "signup" ? "Let’s get you started!" : "Welcome back!"}
          </h1>

          {/* Segmented Pill Switcher */}
          <div className="mb-6 bg-[#F3E7D5] p-1.5 rounded-2xl flex items-center shadow-inner">
            <button
              type="button"
              onClick={() => {
                setMode("signin");
                setErrorMessage("");
                setSuccessMessage("");
              }}
              className={`flex-1 py-3 text-sm font-bold rounded-xl transition-all duration-200 ${
                mode === "signin"
                  ? "bg-white text-[#0A2947] shadow-sm"
                  : "text-[#8B5E3C] hover:text-[#0A2947]"
              }`}
            >
              Sign In
            </button>
            <button
              type="button"
              onClick={() => {
                setMode("signup");
                setErrorMessage("");
                setSuccessMessage("");
              }}
              className={`flex-1 py-3 text-sm font-bold rounded-xl transition-all duration-200 ${
                mode === "signup"
                  ? "bg-white text-[#0A2947] shadow-sm"
                  : "text-[#8B5E3C] hover:text-[#0A2947]"
              }`}
            >
              Sign Up
            </button>
          </div>

          {/* Error & Success Alerts */}
          {errorMessage && (
            <div className="mb-5 p-3.5 rounded-2xl bg-red-50 border border-red-200 text-red-700 text-xs font-semibold">
              {errorMessage}
            </div>
          )}
          {successMessage && (
            <div className="mb-5 p-3.5 rounded-2xl bg-emerald-50 border border-emerald-200 text-emerald-800 text-xs font-semibold">
              {successMessage}
            </div>
          )}

          {/* Form */}
          <form onSubmit={handleSubmit} className="space-y-4">
            
            {/* Email Field */}
            <div
              className={`p-3.5 bg-white rounded-2xl border transition-all duration-200 flex items-center gap-3.5 ${
                focusedInput === "email"
                  ? "border-[#8B5E3C] ring-2 ring-[#8B5E3C]/15 shadow-sm"
                  : "border-gray-200 hover:border-gray-300"
              }`}
            >
              <div className="w-8 h-8 rounded-full bg-[#8B5E3C]/10 flex items-center justify-center text-[#8B5E3C] flex-shrink-0 font-bold text-sm">
                @
              </div>
              <div className="flex-1 min-w-0">
                <label className="block text-[11px] font-semibold text-[#8B5E3C] leading-none mb-1">
                  Email
                </label>
                <input
                  type="email"
                  required
                  placeholder="someone@example.com"
                  value={email}
                  onFocus={() => setFocusedInput("email")}
                  onBlur={() => setFocusedInput(null)}
                  onChange={(e) => setEmail(e.target.value)}
                  className="w-full bg-transparent text-[#0A2947] text-sm font-semibold focus:outline-none placeholder:text-gray-300"
                />
              </div>
            </div>

            {/* Password Field */}
            <div
              className={`p-3.5 bg-white rounded-2xl border transition-all duration-200 flex items-center gap-3.5 ${
                focusedInput === "password"
                  ? "border-[#8B5E3C] ring-2 ring-[#8B5E3C]/15 shadow-sm"
                  : "border-gray-200 hover:border-gray-300"
              }`}
            >
              <div className="w-8 h-8 rounded-full bg-[#8B5E3C]/10 flex items-center justify-center text-[#8B5E3C] flex-shrink-0">
                <svg className="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M15 7a2 2 0 012 2m4 0a6 6 0 01-7.743 5.743L11 17H9v2H7v2H4a1 1 0 01-1-1v-2.586a1 1 0 01.293-.707l5.964-5.964A6 6 0 1121 9z" />
                </svg>
              </div>
              <div className="flex-1 min-w-0">
                <label className="block text-[11px] font-semibold text-[#8B5E3C] leading-none mb-1">
                  Password
                </label>
                <input
                  type={showPassword ? "text" : "password"}
                  required
                  placeholder="•••••••••••••••••"
                  value={password}
                  onFocus={() => setFocusedInput("password")}
                  onBlur={() => setFocusedInput(null)}
                  onChange={(e) => setPassword(e.target.value)}
                  className="w-full bg-transparent text-[#0A2947] text-sm font-semibold focus:outline-none placeholder:text-gray-300"
                />
              </div>
              <button
                type="button"
                onClick={() => setShowPassword(!showPassword)}
                className="text-gray-400 hover:text-[#8B5E3C] p-1 transition-colors"
              >
                {showPassword ? (
                  <svg className="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M13.875 18.825A10.05 10.05 0 0112 19c-4.478 0-8.268-2.943-9.543-7a9.97 9.97 0 011.563-3.029m5.858-5.908a10.025 10.025 0 014.122-.963c4.478 0 8.268 2.943 9.542 7a10.025 10.025 0 01-4.132 5.411m0 0L21 21M3 3l18 18" />
                  </svg>
                ) : (
                  <svg className="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" />
                  </svg>
                )}
              </button>
            </div>

            {/* Confirm Password Field (Sign Up mode) */}
            {mode === "signup" && (
              <div
                className={`p-3.5 bg-white rounded-2xl border transition-all duration-200 flex items-center gap-3.5 ${
                  focusedInput === "confirmPassword"
                    ? "border-[#8B5E3C] ring-2 ring-[#8B5E3C]/15 shadow-sm"
                    : "border-gray-200 hover:border-gray-300"
                }`}
              >
                <div className="w-8 h-8 rounded-full bg-[#8B5E3C]/10 flex items-center justify-center text-[#8B5E3C] flex-shrink-0">
                  <svg className="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M15 7a2 2 0 012 2m4 0a6 6 0 01-7.743 5.743L11 17H9v2H7v2H4a1 1 0 01-1-1v-2.586a1 1 0 01.293-.707l5.964-5.964A6 6 0 1121 9z" />
                  </svg>
                </div>
                <div className="flex-1 min-w-0">
                  <label className="block text-[11px] font-semibold text-[#8B5E3C] leading-none mb-1">
                    Confirm your password
                  </label>
                  <input
                    type={showConfirmPassword ? "text" : "password"}
                    required
                    placeholder="•••••••••••••••••"
                    value={confirmPassword}
                    onFocus={() => setFocusedInput("confirmPassword")}
                    onBlur={() => setFocusedInput(null)}
                    onChange={(e) => setConfirmPassword(e.target.value)}
                    className="w-full bg-transparent text-[#0A2947] text-sm font-semibold focus:outline-none placeholder:text-gray-300"
                  />
                </div>
                <button
                  type="button"
                  onClick={() => setShowConfirmPassword(!showConfirmPassword)}
                  className="text-gray-400 hover:text-[#8B5E3C] p-1 transition-colors"
                >
                  {showConfirmPassword ? (
                    <svg className="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                      <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M13.875 18.825A10.05 10.05 0 0112 19c-4.478 0-8.268-2.943-9.543-7a9.97 9.97 0 011.563-3.029m5.858-5.908a10.025 10.025 0 014.122-.963c4.478 0 8.268 2.943 9.542 7a10.025 10.025 0 01-4.132 5.411m0 0L21 21M3 3l18 18" />
                    </svg>
                  ) : (
                    <svg className="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                      <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
                      <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" />
                    </svg>
                  )}
                </button>
              </div>
            )}

            {/* Primary CTA Solid Button (NO Gradient) */}
            <button
              type="submit"
              disabled={isLoading}
              className="w-full mt-2 py-4 px-6 bg-[#0A2947] hover:bg-[#153A5F] text-white font-bold text-base rounded-full shadow-md active:scale-[0.99] transition-all duration-200 flex items-center justify-center gap-2 cursor-pointer disabled:opacity-75"
            >
              {isLoading ? (
                <svg className="animate-spin h-5 w-5 text-white" fill="none" viewBox="0 0 24 24">
                  <circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4"></circle>
                  <path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
                </svg>
              ) : (
                <span>{mode === "signin" ? "Sign In" : "Continue"}</span>
              )}
            </button>
          </form>

          {/* Divider */}
          <div className="relative flex items-center justify-center my-6">
            <div className="w-full border-t border-gray-100"></div>
            <span className="bg-white px-3 text-xs font-semibold text-gray-400 absolute left-1/2 -translate-x-1/2">
              Or
            </span>
          </div>

          {/* Social Google Button */}
          <button
            type="button"
            onClick={() => alert("Google authentication initiated")}
            className="w-full py-3.5 px-6 bg-white hover:bg-gray-50 text-[#0A2947] font-bold text-sm rounded-full border border-gray-200 shadow-sm hover:shadow transition-all duration-200 flex items-center justify-center gap-3 cursor-pointer"
          >
            <svg className="w-5 h-5" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
              <path d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92c-.26 1.37-1.04 2.53-2.21 3.31v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.09z" fill="#4285F4" />
              <path d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z" fill="#34A853" />
              <path d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.06H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.94l2.85-2.22.81-.63z" fill="#FBBC05" />
              <path d="M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.06l3.66 2.84c.87-2.6 3.3-4.52 6.16-4.52z" fill="#EA4335" />
            </svg>
            <span>{mode === "signin" ? "Sign In with Google" : "Sign Up with Google"}</span>
          </button>

        </div>

        <div className="hidden lg:block text-xs text-gray-400"></div>
      </div>


      {/* RIGHT SIDE: Video Showcase Panel Canvas Card */}
      <div className="hidden lg:flex w-full lg:w-[52%] xl:w-[55%] min-h-screen p-5 xl:p-8 relative flex-col justify-center">
        
        {/* Large Rounded Canvas Card */}
        <div className="w-full h-full bg-[#EFE6D5] rounded-[2.8rem] relative overflow-hidden flex items-center justify-center p-8 xl:p-12 border border-[#E3D7C2]">
          
          {/* Subtle Organic Background Wave Curves */}
          <div className="absolute inset-0 pointer-events-none overflow-hidden">
            <svg className="absolute -top-10 -right-10 w-[700px] h-[700px] opacity-35 text-[#DFD3BF]" viewBox="0 0 600 600" fill="currentColor">
              <path d="M0,300 C200,450 400,150 600,300 L600,0 L0,0 Z" />
            </svg>
            <svg className="absolute -bottom-20 -right-20 w-[650px] h-[650px] opacity-25 text-[#D8CCA9]" viewBox="0 0 600 600" fill="currentColor">
              <path d="M0,300 C150,150 350,450 600,200 L600,600 L0,600 Z" />
            </svg>
          </div>

          {/* Clean Seamless Transparent Video Display */}
          <div className="relative z-10 max-w-xl w-full flex items-center justify-center">
            <video
              autoPlay
              loop
              muted
              playsInline
              className="w-full h-auto max-h-[520px] object-contain mix-blend-multiply"
            >
              <source src="/animate_my_logo.webm" type="video/webm" />
              <source src="/animate_my_logo.mp4" type="video/mp4" />
            </video>
          </div>

        </div>
      </div>

    </div>
  );
}
