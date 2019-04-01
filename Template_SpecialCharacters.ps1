
######################################
#regular expression to shit-can special characters

$String -replace '[^\p{L}\p{Nd}]', ''

#######################################
#function to remove other special charactors

function Remove-Diacritics {
    param ([String]$src = [String]::Empty)
    $normalized = $src.Normalize( [Text.NormalizationForm]::FormD )
    $sb = New-Object Text.StringBuilder
    $normalized.ToCharArray() | ForEach-Object { 
        if ( [Globalization.CharUnicodeInfo]::GetUnicodeCategory($_) -ne [Globalization.UnicodeCategory]::NonSpacingMark) {
            [void]$sb.Append($_)
        }
    }
    $sb.ToString()
}