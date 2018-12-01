Sub stockdata():

  Dim stock As String

  Dim stock_total As Double
  stock_total = 0

  Dim Summary_Table_Row As Integer
  Summary_Table_Row = 2

  Range("I1").Value = "Ticker"
  Range("J1").Value = "Total Stock Volume"

  Dim lastrow As Double
  lastrow = Range("A1").End(xlDown).Row

  For i = 2 To lastrow

    If Cells(i + 1, 1).Value <> Cells(i, 1).Value Then

      stock = Cells(i, 1).Value

      stock_total = stock_total + Cells(i, 7).Value

      
      Range("I" & Summary_Table_Row).Value = stock

      
      Range("J" & Summary_Table_Row).Value = stock_total

      Summary_Table_Row = Summary_Table_Row + 1
      
     
      stock_total = 0

    Else

      
      stock_total = stock_total + Cells(i, 7).Value

    End If

  Next i

End Sub