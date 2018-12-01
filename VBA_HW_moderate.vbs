Sub stockdatamod():

  Dim stock As String

  
  Dim stock_total As Double
  stock_total = 0

  Dim openyear As Double
  openyear = Cells(2, 3).Value
  Dim endyear As Double
  endyear = 0
  
  Dim Summary_Table_Row As Integer
  Summary_Table_Row = 2
  Range("I1").Value = "Ticker"
  Range("J1").Value = "Yearly Change"
  Range("K1").Value = "Percent Change"
  Range("L1").Value = "Total Stock Volume"

  
  Dim lastrow As Double
  lastrow = Range("A1").End(xlDown).Row

  For i = 2 To lastrow

    If Cells(i + 1, 1).Value <> Cells(i, 1).Value Then
      endyear = Cells(i, 6).Value
      stock = Cells(i, 1).Value
      stock_total = stock_total + Cells(i, 7).Value
      Range("I" & Summary_Table_Row).Value = stock

      If openyear = 0 Then
        openyear = 1
      End If
    
      Range("J" & Summary_Table_Row).Value = endyear - openyear
      
      Range("K" & Summary_Table_Row).Value = Str(((endyear - openyear) / openyear) * 100) & "%"
    
      Range("L" & Summary_Table_Row).Value = stock_total

      Summary_Table_Row = Summary_Table_Row + 1
      
      stock_total = 0
      openyear = Cells(i + 1, 3).Value
    
    Else

      stock_total = stock_total + Cells(i, 7).Value

    End If

  Next i

Dim lastrowsum As Double
lastrowsum = Range("J1").End(xlDown).Row

For k = 2 To lastrowsum
    If Range("J" & k).Value < 0 Then
        Range("J" & k).Interior.ColorIndex = 3
    ElseIf Range("J" & k).Value > 0 Then
        Range("J" & k).Interior.ColorIndex = 4
    End If
Next k

End Sub