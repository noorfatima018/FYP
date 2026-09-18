"use client";

import { useState } from "react";
import Image from "next/image";
import Link from "next/link";

export default function RegisterPage() {
  const [role, setRole] = useState<"renter" | "owner" | "both">("renter");
  const [fullName, setFullName] = useState("");
  const [email, setEmail] = useState("");
  const [phone, setPhone] = useState("");
  const [password, setPassword] = useState("");
  const [confirmPassword, setConfirmPassword] = useState("");
  const [agreeTerms, setAgreeTerms] = useState(false);
  const [isLoading, setIsLoading] = useState(false);

  const handleRegister = (e: React.FormEvent) => {
    e.preventDefault();
    if (password !== confirmPassword) {
      alert("Passwords do not match!");
      return;
    }
    if (!agreeTerms) {
      alert("Please agree to the Terms of Service & Privacy Policy.");
      return;
    }

    setIsLoading(true);
    setTimeout(() => {
      setIsLoading(false);
      alert(`Account created successfully for ${fullName} (${role.toUpperCase()})!`);
    }, 1000);
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
              Join the Platform
            </div>
            <h1 className="text-3xl sm:text-4xl font-extrabold leading-tight text-white mb-4">
              Start Sharing & Renting Safely
            </h1>
            <p className="text-[#D5D8CB] text-sm leading-relaxed">
              Create your account to browse high-value cameras, laptops, projectors, and tools with AI risk protection and verified trust badges.
            </p>

            <div className="mt-6 pt-6 border-t border-white/10 space-y-3">
              <div className="flex items-center gap-3 text-xs text-[#D5D8CB]">
                <span className="w-5 h-5 rounded-full bg-[#8B5E3C] text-white flex items-center justify-center text-xs font-bold">✓</span>
                Identity Verification with CNIC support
              </div>
              <div className="flex items-center gap-3 text-xs text-[#D5D8CB]">
                <span className="w-5 h-5 rounded-full bg-[#8B5E3C] text-white flex items-center justify-center text-xs font-bold">✓</span>
                Machine-Learning Risk Score calculation
              </div>
              <div className="flex items-center gap-3 text-xs text-[#D5D8CB]">
                <span className="w-5 h-5 rounded-full bg-[#8B5E3C] text-white flex items-center justify-center text-xs font-bold">✓</span>
                Digital Rental Contracts & Condition Evidence
              </div>
            </div>
          </div>

          <div className="relative z-10 pt-4 border-t border-white/10 flex items-center justify-between text-xs text-[#D5D8CB]">
            <span>© 2026 RentWise</span>
            <span className="flex items-center gap-1">
              <span className="w-2 h-2 rounded-full bg-[#8B5E3C]"></span>
              University of Gujrat
            </span>
          </div>
        </div>

        {/* Right Form Panel */}
        <div className="lg:col-span-7 p-8 sm:p-12 flex flex-col justify-center bg-[#FAF4ED]">
          
          <div className="mb-6">
            <h2 className="text-2xl sm:text-3xl font-bold text-[#0C2340]">Create Account</h2>
            <p className="text-[#8B5E3C] text-sm mt-1 font-medium">Join RentWise as a Renter or Asset Owner</p>
          </div>

          {/* Account Role Selection */}
          <div className="mb-5">
            <label className="block text-xs font-bold uppercase tracking-wider text-[#0C2340] mb-2">
              Primary Account Type
            </label>
            <div className="grid grid-cols-3 gap-2 bg-[#F5ECE1] p-1.5 rounded-xl border border-[#D5D8CB]">
              {(["renter", "owner", "both"] as const).map((r) => (
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
                  {r === "both" ? "Renter & Owner" : r}
                </button>
              ))}
            </div>
          </div>

          {/* Form */}
          <form onSubmit={handleRegister} className="space-y-4">
            
            {/* Full Name */}
            <div>
              <label className="block text-xs font-bold uppercase tracking-wider text-[#0C2340] mb-1">
                Full Name
              </label>
              <input
                type="text"
                required
                placeholder="Noor Fatima"
                value={fullName}
                onChange={(e) => setFullName(e.target.value)}
                className="w-full bg-[#F5ECE1] text-[#0C2340] px-4 py-2.5 rounded-xl border border-[#D5D8CB] text-sm focus:outline-none focus:border-[#8B5E3C] focus:ring-2 focus:ring-[#8B5E3C]/20 transition-all placeholder:text-gray-400"
              />
            </div>

            {/* Email & Phone Grid */}
            <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
              <div>
                <label className="block text-xs font-bold uppercase tracking-wider text-[#0C2340] mb-1">
                  Email Address
                </label>
                <input
                  type="email"
                  required
                  placeholder="user@example.com"
                  value={email}
                  onChange={(e) => setEmail(e.target.value)}
                  className="w-full bg-[#F5ECE1] text-[#0C2340] px-4 py-2.5 rounded-xl border border-[#D5D8CB] text-sm focus:outline-none focus:border-[#8B5E3C] focus:ring-2 focus:ring-[#8B5E3C]/20 transition-all placeholder:text-gray-400"
                />
              </div>

              <div>
                <label className="block text-xs font-bold uppercase tracking-wider text-[#0C2340] mb-1">
                  Phone Number
                </label>
                <input
                  type="tel"
                  required
                  placeholder="+92 300 1234567"
                  value={phone}
                  onChange={(e) => setPhone(e.target.value)}
                  className="w-full bg-[#F5ECE1] text-[#0C2340] px-4 py-2.5 rounded-xl border border-[#D5D8CB] text-sm focus:outline-none focus:border-[#8B5E3C] focus:ring-2 focus:ring-[#8B5E3C]/20 transition-all placeholder:text-gray-400"
                />
              </div>
            </div>

            {/* Passwords Grid */}
            <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
              <div>
                <label className="block text-xs font-bold uppercase tracking-wider text-[#0C2340] mb-1">
                  Password
                </label>
                <input
                  type="password"
                  required
                  placeholder="••••••••"
                  value={password}
                  onChange={(e) => setPassword(e.target.value)}
                  className="w-full bg-[#F5ECE1] text-[#0C2340] px-4 py-2.5 rounded-xl border border-[#D5D8CB] text-sm focus:outline-none focus:border-[#8B5E3C] focus:ring-2 focus:ring-[#8B5E3C]/20 transition-all placeholder:text-gray-400"
                />
              </div>

              <div>
                <label className="block text-xs font-bold uppercase tracking-wider text-[#0C2340] mb-1">
                  Confirm Password
                </label>
                <input
                  type="password"
                  required
                  placeholder="••••••••"
                  value={confirmPassword}
                  onChange={(e) => setConfirmPassword(e.target.value)}
                  className="w-full bg-[#F5ECE1] text-[#0C2340] px-4 py-2.5 rounded-xl border border-[#D5D8CB] text-sm focus:outline-none focus:border-[#8B5E3C] focus:ring-2 focus:ring-[#8B5E3C]/20 transition-all placeholder:text-gray-400"
                />
              </div>
            </div>

            {/* Terms checkbox */}
            <div className="flex items-start gap-2 pt-2">
              <input
                type="checkbox"
                id="terms"
                checked={agreeTerms}
                onChange={(e) => setAgreeTerms(e.target.checked)}
                className="mt-1 rounded text-[#8B5E3C] focus:ring-[#8B5E3C]"
              />
              <label htmlFor="terms" className="text-xs text-[#0C2340] leading-relaxed">
                I agree to the <a href="#" className="font-bold text-[#8B5E3C] hover:underline">Terms of Service</a>, <a href="#" className="font-bold text-[#8B5E3C] hover:underline">Privacy Policy</a>, and identity verification requirements.
              </label>
            </div>

            {/* Register button */}
            <button
              type="submit"
              disabled={isLoading}
              className="w-full mt-3 py-3.5 px-6 bg-[#0C2340] text-white font-bold text-sm rounded-xl hover:bg-[#16365C] border-2 border-[#8B5E3C] transition-all duration-200 shadow-md hover:shadow-lg flex items-center justify-center gap-2"
            >
              {isLoading ? (
                <span className="inline-block w-5 h-5 border-2 border-white border-t-transparent rounded-full animate-spin"></span>
              ) : (
                <>Create RentWise Account →</>
              )}
            </button>
          </form>

          {/* Bottom Link */}
          <p className="mt-6 text-center text-sm text-[#0C2340]">
            Already have an account?{" "}
            <Link href="/login" className="font-bold text-[#8B5E3C] hover:underline">
              Sign In
            </Link>
          </p>

        </div>
      </div>
    </div>
  );
}
