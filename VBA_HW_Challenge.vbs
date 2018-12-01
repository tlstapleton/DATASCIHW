Sub loopallworkbooks():


Dim w as Workbook

For Each w in Workbooks
    w.Activate

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
  
  
    Dim test As Double
    test = 0
    Dim teststring As String
    Dim greatestincreasestock As String
    Dim greatestincrease As Double
    greatestincrease = 0
    Dim greatestdecreasestock As String
    Dim greatestdecrease As Double
    greatestdecrease = 0
    Dim greatestvolumestock As String
    Dim greatestvolume As Double
    greatestvolume = 0

  For i = 2 To lastrow

    If Cells(i + 1, 1).Value <> Cells(i, 1).Value Then
      endyear = Cells(i, 6).Value
    
      stock = Cells(i, 1).Value

      stock_total = stock_total + Cells(i, 7).Value

      Range("I" & Summary_Table_Row).Value = stock
      Range("J" & Summary_Table_Row).Value = endyear - openyear
      If openyear <> 0 Then
      
            test = ((endyear - openyear) / openyear) * 100
    
                If test > greatestincrease Then
                    greatestincrease = test
                    greatestincreasestock = stock
            
                ElseIf test < greatestdecrease Then
                    greatestdecrease = test
                    greatestdecreasestock = stock
        
                End If
            Range("K" & Summary_Table_Row).Value = Str(((endyear - openyear) / openyear) * 100) & "%"
      ElseIf openyear = 0 Then
        Range("K" & Summary_Table_Row).Value = "N/A"
    End If
    
            
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
        
        If Range("L" & k).Value > greatestvolume Then
            greatestvolume = Range("L" & k).Value
            greatestvolumestock = Range("I" & k).Value
        End If
    
    Next k

Range("N2").Value = "Greatest % Increase"
Range("N3").Value = "Greatest % Decrease"
Range("N4").Value = "Greatest Total Volume"
Range("O2").Value = greatestincreasestock
Range("O3").Value = greatestdecreasestock
Range("O4").Value = greatestvolumestock
Range("P2").Value = Str(greatestincrease) & "%"
Range("P3").Value = Str(greatestdecrease) & "%"
Range("P4").Value = greatestvolume

Next


End Sub
