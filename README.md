# PDF Maker  🇵🇸

![PDF Maker Cover](images/package_cover.png)

**pdf_maker** is a simple yet powerful Flutter plugin that lets you design your pages and turn them into high-quality PDF documents without breaking fonts or compromising quality. Create professional-grade PDFs with any design, in any language, all at once. Enjoy easy real-time previews and total control over your layout.

<!-- [![Stand With Palestine](images/banner-no-action.svg)](https://pub.dev/packages/pdf_maker) -->


## ✨ Features

- **Design Freedom**: Create your page layout the way you want, with no restrictions.
- **High-Quality Output**: Preserve font integrity and image quality for crisp, clear PDFs.
- **Multipage Support**: Seamlessly combine multiple pages into a single PDF document.
- **Real-Time Preview**: Instantly preview your designs and make adjustments on the fly.
- **Flexible and Versatile**: Support for any language and any design style.
- **Lightweight and Fast**: Optimized for performance with minimal overhead.

## 🚀 Installation

Add `pdf_maker` to your `pubspec.yaml`:

```yaml
dependencies:
  pdf_maker: ^1.1.0
```

## 🛠️ Usage

### Quick Start

### **How to Design Your Page?**

To design your custom page, you need to create a concrete implementation of the `BlankPage` class. Below is an example of how to define a custom page:

```dart
class TestPage extends BlankPage {
  const TestPage({super.key});

  @override
  Widget createPageContent(BuildContext context) {
    return const Center(
      child: Text('Save Palestine 🇵🇸'),
    );
  }
}
```


## **Generating a Single-Page PDF**  

Now you can generate a PDF from your custom-designed page in just a few simple steps.  


Use `createPDF` to create a multi-page PDF and save the file:   

```dart
ElevatedButton(
  onPressed: () async {
    PDFMaker maker = PDFMaker();
    maker.createPDF(
      const TestPage(),
      setup: PageSetup(
        context: context,
        quality: 4.0,
        scale: 1.0,
        pageFormat: PageFormat.a4,
        margins: 40,
      ),
    ).then((file) {
      saveAndOpen(file);
    });
  },
  child: const Text("Create PDF"),
);
```  

Alternatively, you can generate a PDF using the `BlankPage.createPDF` static method:  

```dart
ElevatedButton(
  onPressed: () async {
    try {
      final pdfFile = await BlankPage.createPDF(
        const TestPage(),
        setup: PageSetup(context: context),
      );
      saveAndOpen(pdfFile);
    } catch (e) {
      print("Error creating PDF: $e");
    }
  },
  child: const Text("Create PDF"),
);
```  

Both approaches allow you to easily create and save PDF files based on your custom-designed pages. 🔥

---

## **Generating a Multi-Page PDF**  

### **1. Define Your Pages**  

Create a list of your custom page widgets:  

```dart
const pages = [Page1(), Page2(), Page3()];

final setup = PageSetup(
  context: context,
  quality: 4.0,
  scale: 1.0,
  pageFormat: PageFormat.a4,
  margins: 40,
  renderMode: PDFRenderMode.isolated,
);
```  

### **2. Generate the PDF**  

Use `createMultiPagePDF` to create a multi-page PDF and save the file:  

```dart
ElevatedButton(
  onPressed: () async {
    PDFMaker maker = PDFMaker();
    maker.createMultiPagePDF(pages, setup: setup).then((file) {
      saveAndOpen(file);
    });
  },
  child: const Text("Create PDF"),
);
```  

This method ensures efficient PDF generation while maintaining high quality and performance. 🚀  

---

## ✨ **Effortless PDF Generation**  

You can easily generate a PDF from a single page or multiple pages using the `toPDF` extension.  

### **Single Page PDF**  

Convert an instance of `BlankPage` into a PDF with just one line of code:  

```dart
final pdfFile = await const TestPage().toPDF(
  setup: PageSetup(context: context),
);
```  

### **Multi-Page PDF**  

Generate a PDF from multiple pages effortlessly:  

```dart
const pages = [Page1(), Page2(), Page3()];
final pdfFile = pages.toPDF();
```  

This streamlined approach ensures a seamless and efficient PDF generation process. 🚀  

---

## ⚠️ Caution: Handling Context

When using the `createPDF` method, it's important to manage the `BuildContext` properly.

- **If you do not pass the `BuildContext`**: You must hard-code text colors and other properties that would otherwise rely on context, as the absence of context means it can't dynamically get them.

- **If you choose to pass the `BuildContext`**: It can use it dynamically to access theme data, colors, and other context-dependent properties and **`It's recomended`**


---

## **Demo Preview 📥**

- [Click here to view the generated invoice PDF](example/demo/invoice.pdf)
- [Click here to view a PDF with multiple pages in different languages](example/demo/pdf_maker_full.pdf)

---

## 📚 **API Reference**

### **`BlankPage`**

`BlankPage` serves as an abstract base class designed for creating custom page templates. Subclasses must implement the `createPageContent` method to define the specific content of each page.

- **Methods**:
  - **`createPageContent(BuildContext context)`**:  
    An abstract method that must be overridden to define the page content. This is where you can customize the content of your page.


### **`PageSetup`**

`PageSetup` is a configuration class that allows you to specify various properties for generating a PDF, such as page format, scaling, margins, and quality.

#### **`PageSetup` Properties:**

- **`pageFormat`**:  
  Specifies the format of the PDF page (e.g., `A4`, `Letter`). This defines the size of each page in the generated PDF.

- **`scale`**:  
  The scale factor applied to the page content. A value of `1.0` represents the original size, values greater than `1.0` scale up the content, and values less than `1.0` scale it down.

- **`margins`**:  
  The margins around the page content, specified in pixels. This determines the spacing between the page content and the edges of the page.

- **`quality`**:  
  Defines the quality level of the generated PDF. A higher value results in better quality but may increase processing time.

- **`context`**:  
  An optional `BuildContext` that allows access to theme data and other contextual information. This is useful for using global styles or configurations while generating the PDF.

- **`renderMode`**:  
  Specifies the rendering mode for the content. The `renderMode` controls how the PDF content is generated in relation to the main UI thread.

#### **Enum Values for `renderMode`:**

- **`isolated`**:  
  Renders the content in a separate isolate for background processing, ensuring the UI thread remains responsive and avoids freezing during PDF generation. Recommended for better performance when generating large or complex PDFs.

- **`normal`**:  
  Renders the content on the main thread (default mode). This can be less efficient for larger PDFs, as it may block the UI thread during rendering.


### **Example Usage:**

```dart
final setup = PageSetup(
  context: context,
  quality: 4.0,
  scale: 1.0,
  pageFormat: PageFormat.a4,
  margins: 40,
  renderMode: PDFRenderMode.isolated, 
);
```


### **`toPDF`**

`toPDF` is an extension method for the `BlankPage` or `List<BlankPage>` class, which simplifies generating a PDF from the instance of the class.

- **Method**:
  - **`toPDF({PageSetup? setup})`**:  
    Converts the `BlankPage` instance to a PDF using the provided `PageSetup` configuration.

  - **Returns**:  
    A `Future<Uint8List>` containing the generated PDF file’s bytes.

### **`createPDF`**

`createPDF` is a method used to generate a PDF from a `BlankPage` instance, based on the given configuration.

- **Method**:
  - **`createPDF(BlankPage page, {PageSetup? setup})`**:  
    Generates a PDF from the specified `BlankPage` instance using the provided `PageSetup`.

  - **Returns**:  
    A `Future<Uint8List>` containing the bytes of the generated PDF.


### **`createMultiPagePDF`**

`createMultiPagePDF` is a method used to generate a single PDF document containing multiple custom pages.

- **Method**:
  - **`createMultiPagePDF(List<BlankPage> pages, {PageSetup? setup})`**:  
    Generates a multi-page PDF from a list of `BlankPage` instances using the provided `PageSetup`.

  - **Returns**:  
    A `Future<Uint8List>` containing the bytes of the generated multi-page PDF.

## 🚀 **Contributing**

I encourage contributions from the developer community to help improve this project. If you encounter any bugs or have ideas for new features, feel free to submit a pull request. Together, we can enhance this project and make it even better! 💡

## 📄 License

Licensed under the MIT License. See the LICENSE file for details.

## 👨‍💻 Author

PDF Maker is maintained by AR Rahman. You can contact me at [arrahman.bd@outlook.com](mailto:arrahman.bd@outlook.com).

If you find PDF Maker helpful, please ⭐️ the repository!


[![Stand With Palestine](https://github.com/arrahmanbd/pdf_maker/raw/master/images/StandWithPalestine.svg)](https://pub.dev/packages/pdf_maker)
 [![Stand With Palestine](https://github.com/arrahmanbd/pdf_maker/raw/master/images/StandWithPalestine.svg)](https://pub.dev/packages/pdf_maker)
 [![Stand With Palestine](https://github.com/arrahmanbd/pdf_maker/raw/master/images/StandWithPalestine.svg)](https://pub.dev/packages/pdf_maker)

