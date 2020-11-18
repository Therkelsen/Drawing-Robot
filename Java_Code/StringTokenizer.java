
package dk.sdu.mmmi.rd1.edgedetect;

public class StringTokenizer {

    String tekst;
    String delim;
    int indeks;

    public StringTokenizer() {
        tekst = "N/A";
        delim = "\n";
        indeks = 0;
    }

    public StringTokenizer(String source) {
        tekst = source;
        delim = "\n";
        indeks = 0;
    }

    public StringTokenizer(String source, String delimiters) {
        tekst = source;
        delim = delimiters;
        indeks = 0;
    }

    public String getSource() {
        return tekst;
    }

    public boolean isDelimiter(char tegn) {
        //System.out.println(delim.indexOf(tegn));
        for (int i = 0; i < delim.length(); i++) {
            if (tegn == delim.charAt(i)) {
                return true;
            }
        }
        return false;
    }

        public boolean hasMoreTokens(){
            for (int i = indeks; i < tekst.length(); i++) {
                if (!isDelimiter(tekst.charAt(i))) {
                    return true;
                }
            }
            return false;
        }

    public String nextToken() {
        String token = "";
        
        while (indeks < tekst.length() && isDelimiter(tekst.charAt(indeks))) {
            indeks++;
        }

        while (indeks < tekst.length() && !isDelimiter(tekst.charAt(indeks))) {
            token += tekst.charAt(indeks);
            indeks ++;
        }
        
        return token;
    }

    public String nextToken(String delimiters) {
        delim = delimiters;
        return nextToken();
    }

    public int countTokens() {
        int counter = 0;
        while (nextToken() != "") {
            counter++;
        }
        return counter;
    }
}
