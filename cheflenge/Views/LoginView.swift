import SwiftUI

struct LoginView: View {

    @State private var identifiant: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    
    @State private var disabledButton: Bool = true
    @State private var registerView: Bool = false
    
    func checkValideForm() -> Void {
        if ((registerView && identifiant != "" && password != "" && confirmPassword != "" && password == confirmPassword) || !registerView && identifiant != "" && password != "") {
            disabledButton = false
        } else {
            disabledButton = true
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                Text("Chef'Lenge").fontWeight(.bold).font(.system(size: 60))
                Spacer()
                Section(header: Text(registerView ? "INSCRIPTION" : "CONNEXION").frame(maxWidth: .infinity, alignment: .leading).fontWeight(.heavy)) {
                    TextField("Identifiant", text: $identifiant).onChange(of: identifiant) {
                        checkValideForm()
                    }.padding()
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.accentColor, lineWidth: 2)
                        )
                    SecureField("Mot de passe", text: $password).onChange(of: password) {
                        checkValideForm()
                    }.padding()
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.accentColor, lineWidth: 2)
                        )
                    if(registerView){
                        SecureField("Confirmation mot de passe", text: $confirmPassword).onChange(of: confirmPassword) {
                            checkValideForm()
                        }.padding()
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.accentColor, lineWidth: 2)
                            )
                    }
                    
                    NavigationLink(destination: ContentView().navigationBarBackButtonHidden(true)) {
                        Text(registerView ? "Inscription" : "Connexion").padding()
                    }.frame(maxWidth: .infinity).foregroundColor(.white).background(Color.accentColor).cornerRadius(10).padding(.vertical).disabled(disabledButton)
                    
                    Button(action: {
                        registerView = !registerView
                    }) {
                        Text(registerView ? "Déjà un compte ? Connectez-vous" : "Pas de compte ? S'inscrire").underline().foregroundColor(.black)
                    }
                }
            }.padding()
        }
    }
}

#Preview {
    LoginView()
}
