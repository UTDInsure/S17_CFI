BEGIN { starttype = "none"
        endtype = "none"
        out = ""
      }

$2 ~ /JBE|JA|JLE|JZ|JNZ|JMP|CLP|RLP|JLP|CALL|RET|JC/ { if (starttype == "none") starttype = $2
                                                    endtype = $2
                                                  }
$2 !~ /JBE|JA|JLE|JZ|JNZ|JMP|CLP|RLP|JLP|CALL|RET|JC/ { out = out $0 "\n"
                                                   }

END { outfile = starttype endtype
      print out >> outfile
    }
