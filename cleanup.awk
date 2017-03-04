BEGIN { starttype = "none"
        endtype = "none"
        out = ""
      }

$2 ~ /JO|JNO|JS|JNS|JE|JZ|JNE|JNZ|JB|JNAE|JC|JNB|JAE|JNC|JBE|JNA|JA|JNBE|JL|JNGE|JGE|JNL|JLE|JNG|JG|JNLE|JP|JPE|JNP|JPO|JCXZ|JECXZ|JMP|CLP|RLP|JLP|CALL|RET/ { if (starttype == "none") starttype = $2
                                                    endtype = $2
                                                  }
$2 !~ /JO|JNO|JS|JNS|JE|JZ|JNE|JNZ|JB|JNAE|JC|JNB|JAE|JNC|JBE|JNA|JA|JNBE|JL|JNGE|JGE|JNL|JLE|JNG|JG|JNLE|JP|JPE|JNP|JPO|JCXZ|JECXZ|JMP|CLP|RLP|JLP|CALL|RET/ { out = out $0 "\n"
                                                   }

END { outfile = starttype endtype
      print out >> outfile
    }
