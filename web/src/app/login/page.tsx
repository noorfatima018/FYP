"use client";

import { useState } from "react";
import Image from "next/image";
import Link from "next/link";

export default function LoginPage() {
  const [authMethod, setAuthMethod] = useState<"password" | "otp">("password");
  const [role, setRole] = useState<"renter" | "owner" | "admin">("renter");
  const [emailOrPhone, setEmailOrPhone] = useState("");
  const [password, setPassword] = useState("");
  const [otpCode, setOtpCode] = useState("");
  const [otpSent, setOtpSent] = useState(false);
  const [isLoading, setIsLoading] = useState(false);

  const handleLogin = (e: React.FormEvent) => {
    e.preventDefault();
    setIsLoading(true);
    setTimeout(() => {
      setIsLoading(false);
      alert(`Logged in as ${role.toUpperCase()} via ${authMethod.toUpperCase()}`);
    }, 1000);
  };

  const handleSendOtp = () => {
    if (!emailOrPhone) {
      alert("Please enter your email or phone number first.");
      return;
    }
    setOtpSent(true);
    alert(`Verification OTP sent to ${emailOrPhone}`);
  };

  return (
    <div className="min-h-screen flex items-center justify-center bg-[#F5ECE1] p-4 sm:p-6 lg:p-8">
      <div className="w-full max-w-5xl bg-[#FAF4ED] rounded-3xl overflow-hidden custom-shadow border border-[#D5D8CB] grid grid-cols-1 lg:grid-cols-12">
        
        {/* Left Branding Panel */}
        <div className="lg:col-span-5 bg-[#0C2340] text-white p-8 sm:p-12 flex flex-col justify-between relative overflow-hidden">
          <div className="absolute -top-16 -left-16 w-64 h-64 bg-[#8B5E3C] opacity-20 rounded-full blur-3xl"></div>
          <div className="absolute -bottom-16 -right-16 w-64 h-64 bg-[#D5D8CB] opacity-10 rounded-full blur-3xl"></div>

          <div className="relative z-10">
            <Link href="/" className="inline-flex items-center gap-3">
              <Image 
                src="/logo.png" 
                alt="RentWise Logo" 
                width={54} 
                height={54} 
                className="rounded-xl shadow-md bg-white p-1"
              />
              <div>
                <span className="text-2xl font-bold tracking-tight text-white">RentWise</span>
                <span className="block text-xs text-[#D5D8CB] font-medium tracking-wider">AI-BASED RENTAL MANAGEMENT</span>
              </div>
            </Link>
          </div>

          <div className="relative z-10 my-10">
            <div className="inline-block px-3 py-1 rounded-full bg-[#8B5E3C]/20 border border-[#8B5E3C] text-[#F5ECE1] text-xs font-semibold uppercase tracking-wider mb-4">
              Trust & Risk Engine
            </div>
            <h1 className="text-3xl sm:text-4xl font-extrabold leading-tight text-white mb-4">
              Secure Asset Sharing, Powered by AI
            </h1>
            <p className="text-[#D5D8CB] text-sm leading-relaxed">
              Log in to access your risk-assessed rental requests, verification badges, digital agreements, and smart inventory tools.
            </p>
          </div>

          <div className="relative z-10 pt-6 border-t border-white/10 flex items-center justify-between text-xs text-[#D5D8CB]">
            <span>© 2026 RentWise</span>
            <span className="flex items-center gap-1">
              <span className="w-2 h-2 rounded-full bg-[#8B5E3C] animate-pulse"></span>
              University of Gujrat
            </span>
          </div>
        </div>

        {/* Right Form Panel */}
        <div className="lg:col-span-7 p-8 sm:p-12 flex flex-col justify-center bg-[#FAF4ED]">
          
          <div className="mb-8">
            <h2 className="text-2xl sm:text-3xl font-bold text-[#0C2340]">Welcome Back</h2>
            <p className="text-[#8B5E3C] text-sm mt-1 font-medium">Please sign in to your RentWise account</p>
          </div>

          {/* Role Selector Tabs */}
          <div className="mb-6">
            <label className="block text-xs font-bold uppercase tracking-wider text-[#0C2340] mb-2">
              Select Your Role
            </label>
            <div className="grid grid-cols-3 gap-2 bg-[#F5ECE1] p-1.5 rounded-xl border border-[#D5D8CB]">
              {(["renter", "owner", "admin"] as const).map((r) => (
                <button
                  key={r}
                  type="button"
                  onClick={() => setRole(r)}
                  className={`py-2 px-3 text-xs font-semibold rounded-lg capitalize transition-all duration-200 ${
                    role === r
                      ? "bg-[#0C2340] text-white shadow-sm"
                      : "text-[#0C2340] hover:bg-[#D5D8CB]/40"
                  }`}
                >
                  {r}
                </button>
              ))}
            </div>
          </div>

          {/* Authentication Method Tabs */}
          <div className="flex border-b border-[#D5D8CB] mb-6">
            <button
              type="button"
              onClick={() => setAuthMethod("password")}
              className={`pb-3 text-sm font-semibold transition-all relative ${
                authMethod === "password"
                  ? "text-[#0C2340] border-b-2 border-[#8B5E3C]"
                  : "text-gray-500 hover:text-[#0C2340]"
              }`}
            >
              Password Login
            </button>
            <button
              type="button"
              onClick={() => setAuthMethod("otp")}
              className={`ml-6 pb-3 text-sm font-semibold transition-all relative ${
                authMethod === "otp"
                  ? "text-[#0C2340] border-b-2 border-[#8B5E3C]"
                  : "text-gray-500 hover:text-[#0C2340]"
              }`}
            >
              Email / Phone OTP
            </button>
          </div>

          {/* Form */}
          <form onSubmit={handleLogin} className="space-y-5">
            <div>
              <label className="block text-xs font-bold uppercase tracking-wider text-[#0C2340] mb-1.5">
                Email Address or Phone Number
              </label>
              <div className="relative">
                <input
                  type="text"
                  required
                  placeholder="name@example.com or +92 300 1234567"
                  value={emailOrPhone}
                  onChange={(e) => setEmailOrPhone(e.target.value)}
                  className="w-full bg-[#F5ECE1] text-[#0C2340] px-4 py-3 rounded-xl border border-[#D5D8CB] text-sm focus:outline-none focus:border-[#8B5E3C] focus:ring-2 focus:ring-[#8B5E3C]/20 transition-all placeholder:text-gray-400"
                />
              </div>
            </div>

            {authMethod === "password" ? (
              <div>
                <div className="flex justify-between items-center mb-1.5">
                  <label className="text-xs font-bold uppercase tracking-wider text-[#0C2340]">
                    Password
                  </label>
                  <a href="#" className="text-xs font-semibold text-[#8B5E3C] hover:underline">
                    Forgot password?
                  </a>
                </div>
                <input
                  type="password"
                  required
                  placeholder="••••••••"
                  value={password}
                  onChange={(e) => setPassword(e.target.value)}
                  className="w-full bg-[#F5ECE1] text-[#0C2340] px-4 py-3 rounded-xl border border-[#D5D8CB] text-sm focus:outline-none focus:border-[#8B5E3C] focus:ring-2 focus:ring-[#8B5E3C]/20 transition-all placeholder:text-gray-400"
                />
              </div>
            ) : (
              <div>
                <label className="block text-xs font-bold uppercase tracking-wider text-[#0C2340] mb-1.5">
                  Verification OTP Code
                </label>
                <div className="flex gap-2">
                  <input
                    type="text"
                    maxLength={6}
                    placeholder="Enter 6-digit code"
                    value={otpCode}
                    onChange={(e) => setOtpCode(e.target.value)}
                    className="flex-1 bg-[#F5ECE1] text-[#0C2340] px-4 py-3 rounded-xl border border-[#D5D8CB] text-sm focus:outline-none focus:border-[#8B5E3C] focus:ring-2 focus:ring-[#8B5E3C]/20 transition-all placeholder:text-gray-400 tracking-widest text-center font-mono font-bold"
                  />
                  <button
                    type="button"
                    onClick={handleSendOtp}
                    className="px-4 py-3 bg-[#8B5E3C] text-white text-xs font-semibold rounded-xl hover:bg-[#724B2E] transition-all shadow-sm whitespace-nowrap"
                  >
                    {otpSent ? "Resend Code" : "Send OTP"}
                  </button>
                </div>
              </div>
            )}

            <button
              type="submit"
              disabled={isLoading}
              className="w-full mt-2 py-3.5 px-6 bg-[#0C2340] text-white font-bold text-sm rounded-xl hover:bg-[#16365C] border-2 border-[#8B5E3C] transition-all duration-200 shadow-md hover:shadow-lg flex items-center justify-center gap-2"
            >
              {isLoading ? (
                <span className="inline-block w-5 h-5 border-2 border-white border-t-transparent rounded-full animate-spin"></span>
              ) : (
                <>Sign In to RentWise →</>
              )}
            </button>
          </form>

          {/* Bottom navigation */}
          <p className="mt-8 text-center text-sm text-[#0C2340]">
            Don&apos;t have an account?{" "}
            <Link href="/register" className="font-bold text-[#8B5E3C] hover:underline">
              Create an Account
            </Link>
          </p>

        </div>
      </div>
    </div>
  );
}
