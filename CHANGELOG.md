# Changelog  

## [1.1.0] - 2025-02-28 

### 🎉 MultiplePage Support  

- **Performance**: Improved efficiency by utilizing isolation for rendering, increasing performance by 50% and reducing main thread load. 

- **RenderUI**: Improved UI rendering by running it in isolation for better performance.  
- **PageSetup**: Added configuration options for `renderMode`, enabling isolated rendering.  
- **createMultiPagePDF**: Allows generating a single PDF document with multiple pages.  
- **toPDF**: Introduced as an extension method for `List<BlankPages>`, enabling conversion of multiple pages into a single PDF file.  

## [1.0.0] - 2025-01-20  

### 🎉 Initial Release  

- **BlankPage**: Introduced as the base class for creating customizable page templates.  
- **PageSetup**: Added configuration options for page format, scale, margins, and quality.  
- **toPDF**: Added as an extension method to easily convert `BlankPage` instances into PDFs.  
- **makePDF**: Introduced as a static method for generating PDFs from `BlankPage` instances.  
- **Documentation**: Included comprehensive documentation and examples for all major features.  

