"use client";

import { useEffect } from "react";

export default function Error({
  error,
  reset,
}: {
  error: Error & { digest?: string };
  reset: () => void;
}) {
  useEffect(() => {
    console.error("App Router Error Caught:", error);
  }, [error]);

  return (
    <div className="min-h-screen bg-[#EFE6D5] flex items-center justify-center p-6 text-[#0A2947] font-sans">
      <div className="bg-white p-8 rounded-3xl shadow-xl max-w-md w-full text-center border border-[#E3D7C2]">
        <div className="w-16 h-16 bg-red-50 text-red-500 rounded-full flex items-center justify-center mx-auto mb-4 font-bold text-2xl">
          !
        </div>
        <h2 className="text-2xl font-bold mb-2">Something went wrong!</h2>
        <p className="text-sm text-gray-600 mb-6">
          An unexpected error occurred while loading this page.
        </p>
        <button
          onClick={() => reset()}
          className="w-full py-3.5 px-6 bg-[#0A2947] hover:bg-[#153A5F] text-white font-bold text-sm rounded-full shadow-md transition-all duration-200 cursor-pointer"
        >
          Try again
        </button>
      </div>
    </div>
  );
}
