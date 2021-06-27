//
//  ContentView.swift
//  BookingTicket_App
//
//  Created by Li-Len on 6/19/21.
//  Copyright © 2021 Li-Len. All rights reserved.
//

import SwiftUI
import Firebase

struct ContentView: View {
    var body: some View {
        Detail()
        //Lobby().preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home: View{
    @State var show = false
    var body: some View{
                VStack(spacing: 15){
                    HStack(alignment: .top){
                        VStack(alignment: .leading, spacing: 15){
                            Text("Browse").font(.largeTitle)
                            Button(action: {
                                
                            }) {
                                HStack(spacing: 8){
                                    Text("Movies In New York")
                                    Image(systemName: "chevron.down").font(.body)
                                }
                                }.foregroundColor(.white)
                        }
                        Spacer()
                        Button(action: {
                            try! Auth.auth().signOut()
                            UserDefaults.standard.set(false, forKey: "status")
                            NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
                        }){
                            Image("icons8-menu-48").renderingMode(.original)
                        }.background(Color("Color-2")).cornerRadius(10).padding(.top, 35)
                        
                    }
                    
                    SearchView().cornerRadius(30)
                    
                    ScrollView(.vertical, showsIndicators: false){
                        VStack(spacing: 15){
                            ForEach(datas){i in
                                ScrollView(.horizontal, showsIndicators: false){
                                    HStack(spacing : 15){
                                        ForEach(i.row){j in
                                            
                                            VStack(alignment: .leading, spacing: 12){
                                                Image(j.image).onTapGesture {
                                                    self.show.toggle()
                                                }
                                                Text(j.name).font(.caption).lineLimit(1).foregroundColor(.white)
                                                Text(j.time).font(.caption).foregroundColor(.white)
                                            }.foregroundColor(Color.black.opacity(0.5)).frame(width: 135)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    

                    
                    
                }.padding(.horizontal, 5).sheet(isPresented: $show){
                    Detail()
        }
    }
}
    

struct Detail : View {
    var body : some View{
        ScrollView(.vertical, showsIndicators: false){
            VStack(spacing: 15){
                HStack{
                    Button(action: {}, label: {
                        Image(systemName: "chevron.left").font(.title)
                    })
                    
                    Spacer()
                    Button(action: {}, label: {
                        Image(systemName: "bookmark").font(.title)
                    })
                }.overlay(
                    Text("Detail Movie").font(.title).fontWeight(.semibold)
                ).padding().foregroundColor(.white)
                
                ZStack{
                    
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.white.opacity(0.2))
                        .padding(.horizontal)
                        .offset(y: 12)
                    
                    Image("Carol")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .cornerRadius(15)
                    
                }
                .frame(width: getRect().width / 1.5, height: getRect().height / 2)
                .padding(.top, 20)
                
                VStack(alignment: .leading, spacing: 15){
                    Text("Carol")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("Director: ..... | 4")
                        .foregroundColor(.white)
                        .overlay(
                            
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                                .offset(x: 35, y: -2)
                            ,alignment: .trailing
                        )
                    
                }
                .padding(.top, 55)
                .padding(.horizontal)
                .padding(.leading, 10)
                .frame(maxWidth: .infinity, alignment: .leading)
                
            }
        }.background(Color("Color").edgesIgnoringSafeArea(.all))
    }
}

extension View{
    func getRect()->CGRect{
        return UIScreen.main.bounds
    }
}


struct SearchView : View {
    @State var txt = ""
    var body : some View{
        HStack(spacing: 15){
            Image(systemName: "magnifyingglass").font(.body)
            TextField("Search Movies", text: $txt)
        }.padding().foregroundColor(.black).background(Color.white)
    }
}

struct Lobby : View {
    @State var status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
    @State var index = 0
    
    var body: some View{
        NavigationView{
            VStack{
                if self.status{
                    Home()
                }
                else{
                    GeometryReader{_ in
                        VStack{
                            Image("icons8-movie-ticket-64").resizable().frame(width: 60, height: 60)
                            
                            ZStack{
                                SignUp(index: self.$index).zIndex(Double(self.index))
                                Login(index: self.$index)
                            }
                            
                        }
                    }.background(Color("Color").edgesIgnoringSafeArea(.all))
                }
            }.padding().background(Color("Color").edgesIgnoringSafeArea(.all)).animation(.spring()).onAppear{
                NotificationCenter.default.addObserver(forName: NSNotification.Name("status"), object: nil, queue: .main) {(_) in
                    let status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
                    self.status = status
                }
            }

        }
}
}


struct CShape: Shape {
    func path(in rect: CGRect) -> Path {
        return Path{path in
            
            path.move(to: CGPoint(x: rect.width, y:100))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: 0,y: rect.height))
            path.addLine(to: CGPoint(x:0, y:0))
        }
    }
    
}
struct CShape1: Shape {
    func path(in rect: CGRect) -> Path {
        return Path{path in
            
            path.move(to: CGPoint(x: 0, y:100))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width,y: rect.height))
            path.addLine(to: CGPoint(x:rect.width, y:0))
        }
    }
    
}

struct Login: View{
    @State var email = ""
    @State var pass = ""
    @Binding var index : Int
    @State var alert = false
    @State var error = ""
    
    var body: some View{
        ZStack{
            ZStack(alignment: .bottom){
                VStack{
                    HStack{
                        VStack(spacing: 10){
                            Text("Login").foregroundColor(self.index == 0 ? .white : .gray).font(.title).fontWeight(.bold)
                            Capsule().fill(self.index == 0 ? Color.blue : Color.clear).frame(width: 100, height: 5)
                        }
                        Spacer(minLength: 0)
                    }.padding(.top,40)
                    
                    VStack{
                        HStack(spacing: 15){
                            Image(systemName: "envelope.fill").foregroundColor(Color("Color-1"))
                            TextField("email Address", text: self.$email)
                        }
                        
                        Divider().background(Color.white.opacity(0.5))
                    }.padding(.horizontal).padding(.top,40)
                    
                    VStack{
                        HStack(spacing: 15){
                            Image(systemName: "eye.slash.fill").foregroundColor(Color("Color-1"))
                            SecureField("Password", text: self.$pass)
                        }
                        
                        Divider().background(Color.white.opacity(0.5))
                    }.padding(.horizontal).padding(.top,30)
                    
                    HStack{
                        Spacer(minLength: 0)
                        Button(action: {
                            
                        }){
                            Text("forget Password?").foregroundColor(Color.white.opacity(0.6))
                        }
                    }
                    
                }.padding().padding(.bottom, 65).background(Color("Color-2")).clipShape(CShape()).contentShape(CShape()).shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: -5).onTapGesture {
                    self.index = 0
                }.cornerRadius(35).padding(.horizontal,20)
                
                Button(action: {
                    self.verify()
                }){
                    Text("Login").foregroundColor(.white).fontWeight(.bold).padding(.vertical).padding(.horizontal, 50).background(Color("Color-1")).clipShape(Capsule()).shadow(color: Color.white.opacity(0.1), radius: 5, x: 0, y: 5)
                }.offset(y:25).opacity(self.index == 0 ? 1 : 0)
                
                
                
            }
            if self.alert{
                ErrorView(alert: self.$alert, error: self.$error)
            }
        }
    }
    
    func verify(){
        if self.email != "" && self.pass != ""{
            Auth.auth().signIn(withEmail: self.email, password: self.pass) {
                (res, err) in
                if err != nil{
                    self.error = err!.localizedDescription
                    self.alert.toggle()
                    return
                }
                print("success")
                UserDefaults.standard.set(true, forKey: "status")
                NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
            }
        }
        else{
            self.error = "Please fill all the contents properly"
            self.alert.toggle()
        }
    }
}

struct SignUp: View{
    @State var email = ""
    @State var pass = ""
    @State var Repass = ""
    @Binding var index : Int
    @State var alert = false
    @State var error = ""
    
    var body: some View{
        ZStack{
            ZStack(alignment: .bottom){
            VStack{
                HStack{
                    Spacer(minLength: 0)
                    VStack(spacing: 10){
                        Text("SignUp").foregroundColor(self.index == 1 ? .white : .gray).font(.title).fontWeight(.bold)
                        Capsule().fill(self.index == 1 ? Color.blue : Color.clear).frame(width: 100, height: 5)
                    }
                }.padding(.top,30)
                
                VStack{
                    HStack(spacing: 15){
                        Image(systemName: "envelope.fill").foregroundColor(Color("Color-1"))
                        TextField("email Address", text: self.$email)
                    }
                    
                    Divider().background(Color.white.opacity(0.5))
                }.padding(.horizontal).padding(.top,40)
                
                VStack{
                    HStack(spacing: 15){
                        Image(systemName: "eye.slash.fill").foregroundColor(Color("Color-1"))
                        SecureField("Password", text: self.$pass)
                    }
                    
                    Divider().background(Color.white.opacity(0.5))
                }.padding(.horizontal).padding(.top,30)
                
                VStack{
                    HStack(spacing: 15){
                        Image(systemName: "eye.slash.fill").foregroundColor(Color("Color-1"))
                        SecureField("Re_password", text: self.$Repass)
                    }
                    
                    Divider().background(Color.white.opacity(0.5))
                }.padding(.horizontal).padding(.top,30)
                
            }.padding().padding(.bottom, 65).background(Color("Color-2")).clipShape(CShape1()).contentShape(CShape1()).shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: -5).onTapGesture {
                self.index = 1
            }.cornerRadius(35).padding(.horizontal,20)
            
            Button(action: {
                self.register()
            }){
                Text("Sign Up").foregroundColor(.white).fontWeight(.bold).padding(.vertical).padding(.horizontal, 50).background(Color("Color-1")).clipShape(Capsule()).shadow(color: Color.white.opacity(0.1), radius: 5, x: 0, y: 5)
            }.offset(y:25).opacity(self.index == 1 ? 1 : 0)
            
        }
            
            if self.alert{
                ErrorView(alert: self.$alert, error: self.$error)
            }
        }
    }
    
    func register(){
        if self.email != "" {
            if self.pass == self.Repass{
                
                Auth.auth().createUser(withEmail: self.email, password: self.pass){
                    (res, err) in
                    if err != nil{
                        self.error = err!.localizedDescription
                        self.alert.toggle()
                    }
                    print("success")
                    UserDefaults.standard.set(true, forKey: "status")
                    NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
                }
            }
            else{
                self.error = "Password mismatch"
                self.alert.toggle()
                return
            }
        }
        else{
            self.error = "Please fill all the contents properly"
            self.alert.toggle()
        }
    }
}

struct ErrorView : View {
    @State var color = Color.black.opacity(0.7)
    @Binding var alert : Bool
    @Binding var error : String
    
    var body: some View{
        GeometryReader{_ in
            VStack{
                HStack{
                    Text("Error").font(.title).fontWeight(.bold).foregroundColor(self.color)
                    
                    Spacer()
                }.padding(.horizontal, 25)
                
                Text(self.error).foregroundColor(.black).padding(.top).padding(.horizontal, 25)
                
                Button(action: {
                    self.alert.toggle()
                }){
                    Text("Cancel").foregroundColor(.white).padding(.vertical).frame(width: UIScreen.main.bounds.width - 120)
                }.background(Color("Color")).cornerRadius(10).padding(.top, 25)
                
                
            }.padding(.vertical, 25).frame(width: UIScreen.main.bounds.width - 70).background(Color.white).cornerRadius(15)
        }.background(Color.black.opacity(0.35).edgesIgnoringSafeArea(.all))
    }
}

struct type : Identifiable{
    var id : Int
    var row : [row]
}

struct row : Identifiable{
    var id : Int
    var name : String
    var time : String
    var image : String
}

struct datetype : Identifiable{
    var id : Int
    var date : String
    var day : String
}

var datas = [
type(id: 0, row: [
    row(id: 0, name: "movie_1", time: "1h 12m", image: "Dora"),
    row(id: 1, name: "movie_2", time: "1h 12m", image: "Dora"),
    row(id: 2, name: "movie_3", time: "1h 12m", image: "Dora"),
]),
type(id: 1, row: [
    row(id: 0, name: "movie_1", time: "1h 12m", image: "Dora"),
    row(id: 1, name: "movie_2", time: "1h 12m", image: "Dora"),
    row(id: 2, name: "movie_3", time: "1h 12m", image: "Dora"),
]),
type(id: 2, row: [
    row(id: 0, name: "movie_1", time: "1h 12m", image: "Dora"),
    row(id: 1, name: "movie_2", time: "1h 12m", image: "Dora"),
    row(id: 2, name: "movie_3", time: "1h 12m", image: "Dora"),
]),
]
