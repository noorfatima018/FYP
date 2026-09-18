import Image from "next/image";
import Link from "next/link";

export default function Home() {
  return (
    <div className="min-h-screen bg-[#F5ECE1] text-[#0C2340] flex flex-col">
      {/* Header Navigation */}
      <header className="bg-[#0C2340] text-white px-6 lg:px-12 py-4 shadow-md">
        <div className="max-w-7xl mx-auto flex items-center justify-between">
          <Link href="/" className="flex items-center gap-3">
            <Image 
              src="/logo.png" 
              alt="RentWise Logo" 
              width={46} 
              height={46} 
              className="rounded-lg bg-white p-1"
            />
            <div>
              <span className="text-xl font-bold tracking-tight text-white">RentWise</span>
              <span className="block text-[10px] text-[#D5D8CB] font-medium tracking-wider">P2P RENTAL PLATFORM</span>
            </div>
          </Link>

          <div className="flex items-center gap-3 sm:gap-4">
            <Link
              href="/login"
              className="px-4 py-2 rounded-xl text-sm font-semibold text-white hover:text-[#D5D8CB] transition-all"
            >
              Sign In
            </Link>
            <Link
              href="/register"
              className="px-5 py-2.5 rounded-xl text-sm font-bold bg-[#8B5E3C] hover:bg-[#724B2E] text-white transition-all shadow-sm border border-white/20"
            >
              Get Started
            </Link>
          </div>
        </div>
      </header>

      {/* Hero Section */}
      <main className="flex-1 max-w-7xl w-full mx-auto px-6 lg:px-12 py-12 lg:py-20 flex flex-col justify-center">
        <div className="grid grid-cols-1 lg:grid-cols-12 gap-12 items-center">
          
          {/* Left Text */}
          <div className="lg:col-span-7 space-y-6">
            <div className="inline-flex items-center gap-2 px-3.5 py-1.5 rounded-full bg-[#8B5E3C]/15 border border-[#8B5E3C] text-[#8B5E3C] text-xs font-bold uppercase tracking-wider">
              <span>🛡️</span> AI-Based Risk-Aware Rental Management
            </div>

            <h1 className="text-4xl sm:text-5xl lg:text-6xl font-extrabold leading-tight text-[#0C2340]">
              Don&apos;t just match rentals — <span className="text-[#8B5E3C]">protect both parties.</span>
            </h1>

            <p className="text-lg text-[#0C2340]/80 leading-relaxed max-w-2xl">
              RentWise connects renters and high-value asset owners (cameras, laptops, projectors, tools) backed by machine-learning risk prediction, explainable factors, digital contracts, and condition evidence tracking.
            </p>

            <div className="pt-4 flex flex-wrap items-center gap-4">
              <Link
                href="/login"
                className="px-8 py-4 rounded-xl text-base font-bold bg-[#0C2340] hover:bg-[#16365C] text-white border-2 border-[#8B5E3C] transition-all shadow-md hover:shadow-xl flex items-center gap-2"
              >
                Launch App & Log In →
              </Link>
              <Link
                href="/register"
                className="px-8 py-4 rounded-xl text-base font-bold bg-[#FAF4ED] hover:bg-[#D5D8CB]/40 text-[#0C2340] border border-[#D5D8CB] transition-all"
              >
                Create Account
              </Link>
            </div>

            {/* Feature Highlights Pill Row */}
            <div className="pt-8 border-t border-[#D5D8CB] grid grid-cols-3 gap-4 text-center">
              <div className="bg-[#FAF4ED] p-3 rounded-xl border border-[#D5D8CB]">
                <span className="block text-xl font-bold text-[#8B5E3C]">ML Risk</span>
                <span className="text-xs text-gray-600 font-medium">Scikit & XGBoost</span>
              </div>
              <div className="bg-[#FAF4ED] p-3 rounded-xl border border-[#D5D8CB]">
                <span className="block text-xl font-bold text-[#0C2340]">CNIC Auth</span>
                <span className="text-xs text-gray-600 font-medium">Identity Security</span>
              </div>
              <div className="bg-[#FAF4ED] p-3 rounded-xl border border-[#D5D8CB]">
                <span className="block text-xl font-bold text-[#8B5E3C]">AI Assistant</span>
                <span className="text-xs text-gray-600 font-medium">NLP Recommendations</span>
              </div>
            </div>
          </div>

          {/* Right Preview Card */}
          <div className="lg:col-span-5 flex justify-center">
            <div className="w-full max-w-md bg-[#FAF4ED] p-8 rounded-3xl border border-[#D5D8CB] custom-shadow text-center relative overflow-hidden">
              <div className="absolute top-0 right-0 w-32 h-32 bg-[#8B5E3C]/10 rounded-full blur-2xl"></div>
              
              <Image 
                src="/logo.png" 
                alt="RentWise Logo Preview" 
                width={140} 
                height={140} 
                className="mx-auto mb-6 rounded-2xl shadow-lg bg-white p-2 border border-[#D5D8CB]"
              />

              <h3 className="text-2xl font-bold text-[#0C2340] mb-2">RentWise Platform</h3>
              <p className="text-sm text-[#8B5E3C] font-semibold mb-6">University of Gujrat — FYP Project</p>

              <div className="space-y-3 text-left bg-[#F5ECE1] p-4 rounded-2xl border border-[#D5D8CB] mb-6 text-xs text-[#0C2340]">
                <div className="flex justify-between items-center py-1 border-b border-[#D5D8CB]/60">
                  <span className="font-medium text-gray-600">Supervisor</span>
                  <span className="font-bold">Mr. Zafar Mehmood</span>
                </div>
                <div className="flex justify-between items-center py-1 border-b border-[#D5D8CB]/60">
                  <span className="font-medium text-gray-600">Team</span>
                  <span className="font-bold">Areeba · Noor · Imtishal</span>
                </div>
                <div className="flex justify-between items-center py-1">
                  <span className="font-medium text-gray-600">Theme Palette</span>
                  <span className="font-bold flex items-center gap-1">
                    <span className="w-3 h-3 rounded-full bg-[#0C2340]"></span>
                    <span className="w-3 h-3 rounded-full bg-[#8B5E3C]"></span>
                    <span className="w-3 h-3 rounded-full bg-[#F5ECE1] border border-gray-400"></span>
                    <span className="w-3 h-3 rounded-full bg-[#D5D8CB]"></span>
                  </span>
                </div>
              </div>

              <div className="grid grid-cols-2 gap-3">
                <Link
                  href="/login"
                  className="py-3 px-4 bg-[#0C2340] text-white font-bold text-xs rounded-xl hover:bg-[#16365C] transition-all border border-[#8B5E3C]"
                >
                  Sign In →
                </Link>
                <Link
                  href="/register"
                  className="py-3 px-4 bg-[#8B5E3C] text-white font-bold text-xs rounded-xl hover:bg-[#724B2E] transition-all"
                >
                  Register →
                </Link>
              </div>

            </div>
          </div>

        </div>
      </main>

      {/* Footer */}
      <footer className="bg-[#0C2340] text-[#D5D8CB] text-xs py-6 px-6 text-center border-t border-white/10">
        <div className="max-w-7xl mx-auto flex flex-col sm:flex-row items-center justify-between gap-4">
          <p>© 2026 RentWise — Department of Computer Science, Faculty of Computing & IT, University of Gujrat.</p>
          <div className="flex gap-6">
            <Link href="/login" className="hover:text-white">Sign In</Link>
            <Link href="/register" className="hover:text-white">Create Account</Link>
          </div>
        </div>
      </footer>
    </div>
  );
}
