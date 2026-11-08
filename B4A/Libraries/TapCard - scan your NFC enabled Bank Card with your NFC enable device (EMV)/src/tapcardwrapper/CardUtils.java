package tapcardwrapper;

import android.text.TextUtils;

import io.github.tapcard.emvnfccard.enums.EmvCardScheme;

/**
 * Utils class for card
 *
 * @author Millau Julien
 */
final class CardUtils {

    /**
     * Private constructor
     */
    private CardUtils() {
    }

    /**
     * Method used to format card number
     *
     * @param pCardNumber card number to display
     * @param pType       card type
     * @return the card number formated
     */
    static String formatCardNumber(final String pCardNumber, final EmvCardScheme pType) {
        String ret;
        if (!TextUtils.isEmpty(pCardNumber)) {
            // format amex
            if (pType != null && pType == EmvCardScheme.AMERICAN_EXPRESS) {
                ret = deleteWhitespace(pCardNumber).replaceFirst("\\d{4}", "$0 ").replaceFirst("\\d{6}", "$0 ")
                        .replaceFirst("\\d{5}", "$0").trim();
            } else {
                ret = deleteWhitespace(pCardNumber).replaceAll("\\d{4}", "$0 ").trim();
            }
        } else {
            ret = "0000 0000 0000 0000";
        }
        return ret;
    }

    /**
     * <p>Deletes all whitespaces from a String as defined by
     * {@link Character#isWhitespace(char)}.</p>
     * <p>
     * <pre>
     * StringUtils.deleteWhitespace(null)         = null
     * StringUtils.deleteWhitespace("")           = ""
     * StringUtils.deleteWhitespace("abc")        = "abc"
     * StringUtils.deleteWhitespace("   ab  c  ") = "abc"
     * </pre>
     *
     * @param str the String to delete whitespace from, may be null
     * @return the String without whitespaces, {@code null} if null String input
     */
    private static String deleteWhitespace(String str) {
        if (TextUtils.isEmpty(str)) {
            return str;
        }
        int sz = str.length();
        char[] chs = new char[sz];
        int count = 0;
        for (int i = 0; i < sz; i++) {
            if (!Character.isWhitespace(str.charAt(i))) {
                chs[count++] = str.charAt(i);
            }
        }
        if (count == sz) {
            return str;
        }
        return new String(chs, 0, count);
    }

}
