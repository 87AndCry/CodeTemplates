$From = ""
Tto = ""
$CC = ""
$BCC = ""
$SMTP = ""
$Attachments = "", ""
$Subject = ""
$Body = "" 

Send-MailMessage -From $from -SmtpServer $SMTP -Subject $Subject -BodyAsHtml $Body -Cc $CC -Attachments $attachments    