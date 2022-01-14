//
//  MessageView.swift
//  NewTest4
//
//  Created by Никита Куркурин on 09.12.2021.
//

import SwiftUI


extension UIColor {
    var hexString: String {
        let components = cgColor.components
        let r: CGFloat = components?[0] ?? 0.0
        let g: CGFloat = components?[1] ?? 0.0
        let b: CGFloat = components?[2] ?? 0.0

        let hexString = String(format: "#%02lX%02lX%02lX", lroundf(Float(r * 255)), lroundf(Float(g * 255)),
                lroundf(Float(b * 255)))

        return hexString
    }
}


extension String {
    func htmlAttributed(family: String?, size: CGFloat, color: UIColor) -> NSAttributedString? {
        do {
            let htmlCSSString = "<style>" +
                    "html *" +
                    "{" +
                    "font-size: \(size)pt !important;" +
                    "color: #\(color.hexString) !important;" +
                    "font-family: \(family ?? "Helvetica"), Helvetica !important;" +
                    "}</style> \(self)"

            guard let data = htmlCSSString.data(using: String.Encoding.utf8) else {
                return nil
            }

            return try NSAttributedString(data: data,
                    options: [.documentType: NSAttributedString.DocumentType.html,
                              .characterEncoding: String.Encoding.utf8.rawValue],
                    documentAttributes: nil)
        } catch {
            print("error: ", error)
            return nil
        }
    }
}

//
//func createHtmlLabel(with html: String) -> UILabel {
//    let htmlMock = """
//                   <b>hello</b>, <i>world</i>
//                   """
//
//    let descriprionLabel = ()
//    descriprionLabel.attributedText = htmlMock.htmlAttributed(family: "Helvetica", size: 15, color: .red)
//
//    return descriprionLabel
//}


struct SUILabel: UIViewRepresentable {
    let text: String

    private(set) var preferredMaxLayoutWidth: CGFloat = 0

    func makeUIView(context: UIViewRepresentableContext<SUILabel>) -> UILabel {
        let label = UILabel()
//        label.text = text
//        label.numberOfLines = 0
//        label.preferredMaxLayoutWidth = preferredMaxLayoutWidth
//        label.backgroundColor = UIColor.black
//        label.textColor = UIColor.white
        label.attributedText = text.htmlAttributed(family: "Helvetica", size: 15, color: .red)
        return label
    }

    func updateUIView(_ uiView: UILabel, context: UIViewRepresentableContext<SUILabel>) { }
}


struct MessageView: View {
    let login: String
    let id_: Int
    let title_: String
    let from_: String
    let when_: String
    let body_: String
    @State var attachs: [MessagesResponse.Attach]
    @State private var showingExporter = false

    var body: some View {
        VStack {
//            pdfView
            Text(title_)
            Divider()
            HStack{
                Text(from_).font(.system(size: 10))
                Divider().frame(height: 20)
                Text(when_).font(.system(size: 10))
            }
            Divider()
            SUILabel(text: body_)
            Spacer()
            List {
                ForEach(0..<attachs.count, id: \.self) { attach_index in
                    NavigationLink(destination: PDFReaderView(url: getDocumentsDirectory().appendingPathComponent(attachs[attach_index].name))) {
                        Text(attachs[attach_index].name)
                    }
                }
            }.frame(height: 85)
        }.onAppear {
            decrypt_files(from_: from_, to_: login, attachs: attachs) {  }
            set_seen(login: login, uid: id_) {  }
        }
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView(login: "Login",
                    id_: 123,
                    title_: "title",
                    from_: "from",
                    when_: "when",
                    body_: "body",
                    attachs: []
                )
    }
}
