import SwiftUI

struct ProfileView: View {
    @State private var username: String = ""
    @State private var fullName: String = ""
    @State private var email: String = ""
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            DottedBackgroundView(
                dotColor: Color.gray.opacity(0.3),
                animatedDotColor: .blue.opacity(1),
                backgroundColor: Color(UIColor.systemGroupedBackground)
            )
            .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 20) {
                    // Header
                    HStack {
                        Text("Profile")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.top)
                    
                    // Profile Fields
                    VStack(spacing: 20) {
                        ProfileField(title: "Username", text: $username, placeholder: "Enter username")
                        ProfileField(title: "Full Name", text: $fullName, placeholder: "Enter full name")
                        ProfileField(title: "Email", text: $email, placeholder: "Enter email")
                            .keyboardType(.emailAddress)
                    }
                    .padding()
                    .background(Color(UIColor.secondarySystemGroupedBackground))
                    .cornerRadius(15)
                    
                    // Actions
                    VStack(spacing: 15) {
                        Button(action: {
                            // Action for change password
                        }) {
                            Text("Change Password")
                        }
                        .buttonStyle(ProfileButtonStyle())
                        
                        Button(action: {
                            // Action for delete account
                        }) {
                            Text("Delete Account")
                        }
                        .buttonStyle(ProfileButtonStyle(color: .red))
                        .disabled(true)
                    }
                    .padding(.top)
                }
                .padding()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                }
            }
        }
    }
}

// Rest of the code (ProfileField, ProfileButtonStyle, and ProfileView_Previews) remains unchanged


struct ProfileField: View {
    let title: String
    @Binding var text: String
    let placeholder: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
            TextField(placeholder, text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
    }
}

struct ProfileButtonStyle: ButtonStyle {
    var color: Color = .blue
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(color)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color(UIColor.tertiarySystemGroupedBackground))
            .cornerRadius(10)
            .opacity(configuration.isPressed ? 0.8 : 1.0)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProfileView()
        }
    }
}
