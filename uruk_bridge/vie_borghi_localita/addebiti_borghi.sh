#/!/bin/sh

# Download vie
/root/vie_borghi_localita/downloader-vie.sh

# Estrai spedizioni che hanno come Località Latina ma hanno come strade, strade di Borghi
/root/vie_borghi_localita/estrai_strade_oggi.sh

# Manda Email
/root/vie_borghi_localita/email.sh
