//
// Created by Никита Куркурин on 12.01.2022.
//

import SwiftUI
import PDFKit


struct PDFReader: UIViewRepresentable {
    let url: URL

    func makeUIView(context: UIViewRepresentableContext<PDFReader>) -> PDFReader.UIViewType {
        let pdfView = PDFView()
        pdfView.document = PDFDocument(url: url)
        pdfView.autoScales = true
        return pdfView
    }

    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<PDFReader>) {
        // Update the view.
    }
}


struct PDFReaderView: View {
    let url: URL

    var body: some View {
        PDFReader(url: url)
        .navigationTitle(url.lastPathComponent)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: BackButton(button_name: "Письмо"))
    }
}


//struct Elements_Previews: PreviewProvider {
//    static var previews: some View {
//        Elements()
//    }
//}