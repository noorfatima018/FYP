import AuthScreen from "@/components/AuthScreen";

export const metadata = {
  title: "Sign Up - RentWise",
  description: "Create a RentWise account to rent or list high-value items with AI risk protection.",
};

export default function RegisterPage() {
  return <AuthScreen initialMode="signup" />;
}
