<#Pull from excel sheet#>
$objExcel = new-object -comobject excel.application  
$objExcel.ScreenUpdating = $true
$objExcel.DisplayAlerts = $true
$objExcel.Visible = $true
$UserWorkBook = $objExcel.Workbooks.Open("C:\Scripts\AnExcelSheet.xlsx") 
$UserWorksheet = $UserWorkBook.Worksheets.Item(1)
Do {

    #Load Vars from ExcelSheet
    #Inputs from sheet
    [string]$ColumA = $UserWorksheet.Cells.Item($intRow, 1).Value() #Colum A
    [string]$ColumB = $UserWorksheet.Cells.Item($intRow, 2).Value() #Colum B
    [string]$ColumC = $UserWorksheet.Cells.Item($intRow, 3).Value() #Colum C
    [string]$ColumD = $UserWorksheet.Cells.Item($intRow, 4).Value() #Colum D
    [string]$ColumE = $UserWorksheet.Cells.Item($intRow, 5).Value() #Colum E
    [string]$ColumF = $UserWorksheet.Cells.Item($intRow, 6).Value() #Colum F
    [string]$ColumG = $UserWorksheet.Cells.Item($intRow, 7).Value() #Colum g

    #+++++++++++++++++++++++++++

    # Do stuff between lines


    #+++++++++++++++++++++++++++


    $intRow++ #advance next line
  
} While ($UserWorksheet.Cells.Item($intRow, 1).Value() -ne $null) #Do this while coloum A is not null


#$objExcel.Visible = $True
#$objExcel.DisplayAlerts = $True
#$objExcel.ScreenUpdating = $True
#$UserWorkBook.save()
$UserWorkBook.Close()
$objExcel.Quit()


<##>