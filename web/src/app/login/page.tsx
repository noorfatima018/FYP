import AuthScreen from "@/components/AuthScreen";

export const metadata = {
  title: "Sign In - RentWise",
  description: "Sign in to your RentWise account to manage rentals, view risk assessments, and interact with asset owners.",
};

export default function LoginPage() {
  return <AuthScreen initialMode="signin" />;
}
