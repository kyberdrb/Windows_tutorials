# Print Conductor - alternative

1. Download PDFtoPrinter

    http://www.columbia.edu/~em36/PDFtoPrinter.exe
    
1. Test the printing from the PowerShell on an example PDF document.

    Open PowerShell as standard user and enter following commands

        cd Downloads
        
        .\PDFtoPrinter.exe ".\Example Document.pdf" "PRINTER NAME"

    The document will be printed on the printer with matching name. _Assuming that the printer with such name exists, is enabled, has paper in tray or feeder and is operational._


    Wait to print another document
    
        Start-Process -FilePath .\Downloads\PDFtoPrinter.exe -ArgumentList """C:\Users\USER_1\PATH\TO\Example Document.pdf""","""PRINTER NAME"""

1. Batch print all PDF files in a directory that match a pattern in the file name

        Get-ChildItem "C:\Users\Cfl\Downloads" -Filter "Faktura_2022*.pdf" | % {
            $full_path_to_pdf_doc=$_.FullName
            echo "$full_path_to_pdf_doc"
            Start-Process -FilePath "C:\Users\Cfl\Downloads\PDFtoPrinter.exe" -ArgumentList """$full_path_to_pdf_doc""","""EPSON M2170 Series"""  -Wait
        }
        
    Check number of documents to verify that all documents had been printed:
    
          find /c/Users/USER_1/PATH/TO/DOCUMENTS -name "Beginning name*.pdf" | wc --lines
          
## Sources

Printing from command line

- https://duckduckgo.com/?q=print+pdf+command+line&ia=web
- https://stackoverflow.com/questions/19124808/printing-pdfs-from-windows-command-line
- https://www.cmd2printer.com/how-to/print-pdf-command-line
    - through **2Printer** - trial and paid
- https://groups.google.com/g/adobe.acrobat.windows/c/8sUVf4MNips?pli=1
    - through **Adobe Acrobat CLI** - leaves GUI open
- https://parzibyte.me/blog/en/2021/03/21/windows-print-pdf-cmd-pdftoprinter/
    - through **PDFtoPrinter** - **free and preferred**
- **http://www.columbia.edu/~em36/pdftoprinter.html**
- https://www.google.com/search?client=opera&q=pdftoprint&sourceid=opera&ie=UTF-8&oe=UTF-8
- https://community.adobe.com/t5/acrobat-reader-discussions/how-to-print-a-pdf-from-the-command-line/m-p/8941837
- https://www.verypdf.com/app/pdf-print-cmd/
    - through **PDFPrint** - trial and paid
- https://www.brooksnet.com/lpd/how-print-pdf-files-command-line-windows-printer
- https://parzibyte.me/blog/en/2021/03/21/windows-print-pdf-cmd-pdftoprinter/
- https://www.google.com/search?client=opera&q=2printer&sourceid=opera&ie=UTF-8&oe=UTF-8
- https://www.cmd2printer.com/download
- https://duckduckgo.com/?q=print+word+doc+command+line+windows&ia=web
- https://stackoverflow.com/questions/2749144/how-can-i-print-a-file-from-the-command-line

PowerShell

- Google: powershell find all files pdf
- https://www.google.com/search?client=opera&q=iterate+all+files+with+extension+powershell&sourceid=opera&ie=UTF-8&oe=UTF-8
- https://stackoverflow.com/questions/18847145/loop-through-files-in-a-directory-using-powershell
- https://www.google.com/search?client=opera&q=get-childitem+full+path&sourceid=opera&ie=UTF-8&oe=UTF-8
- https://stackoverflow.com/questions/13126175/get-full-path-of-the-files-in-powershell
- https://www.google.com/search?client=opera&q=powershell+wc+equivalent&sourceid=opera&ie=UTF-8&oe=UTF-8
- https://www.google.com/search?client=opera&q=powershell+delay&sourceid=opera&ie=UTF-8&oe=UTF-8
- https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/start-sleep?view=powershell-7.3
- https://www.google.com/search?client=opera&q=powershell+wait+for+process+to+finish&sourceid=opera&ie=UTF-8&oe=UTF-8
- https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/wait-process?view=powershell-7.3
- https://linuxhint.com/powershell-wait-for-command-to-finish/
- Google: start-process argument list example
- https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/start-process?view=powershell-7.3
- https://lazyadmin.nl/powershell/start-process/
- https://www.google.com/search?client=opera&q=powershell+argumentlist+not+working&sourceid=opera&ie=UTF-8&oe=UTF-8
- https://stackoverflow.com/questions/62594332/powershell-script-argumentlist-not-working-correctly
- https://www.google.com/search?client=opera&q=argumentlist+escape&sourceid=opera&ie=UTF-8&oe=UTF-8
- https://stackoverflow.com/questions/30524456/powershell-quotes-for-start-process-argumentlist
- https://github.com/PowerShell/PowerShell/issues/5576

Merging documents - not necessary but a viable alternative

- Google: pdf merge windows command line powershell
- https://duckduckgo.com/?q=windows+merge+pdf+command+line&ia=web
- https://learn.microsoft.com/en-us/answers/questions/1008494/merge-pdf-using-powershell-or-batch-file-or-vbs-or.html
- https://evotec.xyz/merging-splitting-and-creating-pdf-files-with-powershell/
- Google: install module is not recognized powershell 6.1 windows 7
- https://www.sharepointdiary.com/2020/04/term-install-module-is-not-recognized-as-name-of-cmdlet-function-script-file-operable-program.html
- https://www.google.com/search?client=opera&q=show+powershell+version&sourceid=opera&ie=UTF-8&oe=UTF-8
- https://www.microsoft.com/en-us/download/confirmation.aspx?id=54616
