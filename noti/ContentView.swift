import SwiftUI

struct ContentView: View {
    @State private var account: String = ""
    @State private var amount: String = ""
    @State private var date: Date = Date()
    @State private var time: Date = Date()
    @State private var service: String = ""
    @State private var note: String = ""
    @State private var showUpdateAlert = false

    var body: some View {
        ZStack {
            Image("Background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            VStack {
                Text("Tạo Thông Báo")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()

                Form {
                    Section(header: Text("Thông Tin")) {
                        TextField("Số Tài Khoản", text: $account)
                        TextField("Số Tiền Nhận Hoặc Trừ", text: $amount)
                        DatePicker("Ngày", selection: $date, displayedComponents: .date)
                        DatePicker("Thời Gian", selection: $time, displayedComponents: .hourAndMinute)
                        TextField("Số Dư", text: $service)
                        TextField("Nội Dung Chuyển Khoản", text: $note)
                    }
                }
                .background(Color.white.opacity(0.8))
                .cornerRadius(30)
                .padding(40)

                Button(action: {
                    NotificationManager.shared.scheduleNotification(
                        account: account,
                        amount: amount,
                        date: date,
                        time: time,
                        service: service,
                        note: note
                    )
                }) {
                    Text("Gửi Thông Báo")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()

                Spacer()

                Text("MB Bank Fake By Weans(haininh.site)")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .italic()
                    .padding()
            }
            .onAppear {
                NotificationManager.shared.requestAuthorization()
            }
        }
        .onAppear {
                    showUpdateAlert = true
                }
        .alert(isPresented: $showUpdateAlert) {
            Alert(
                title: Text("MB Bank Fake."),
                message: Text("App By HHNiOS(haininh.site)"),
                dismissButton: .cancel(Text("Đóng"))
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
