﻿<?lasso
/**!
valid_nanp
Determines whether a string contains a valid phone number according to the North American Numbering Plan <http://en.wikipedia.org/wiki/North_American_Numbering_Plan>.  Validation ignores all non-numeric characters.  Additionally the number must have at least 10 digits and does not begin with "+1".  Phone numbers with extensions are permitted, where any digit beyond the first 10 digits forms the extension.  Optionally formats the output, substituting "#" for digits, and inserting any other arbitrary character.

    Parameters:
    -number (required) The phone number to test and optionally format.
    -format (optional) The format string.
**/
define valid_nanp(
    -number::string,
    -format::string=''
) => {
    local(v) = false    // local stores whether a number is valid
    // Strip non-digits
    #number = string_replaceregexp(#number, -find='\\D', -replace='')
    #number -> size < 10 ? return false

    // validation requirements according to NANP, with optional extension
    if(integer(#number->substring(1,1)) >= 2
        && integer(#number->substring(2,1)) <= 8
        && integer(#number->substring(4,1)) >= 2
        && #number -> size >= 10) => {
        #v = true
    }

    if(#format -> size > 0 && #v) => {
        // format the number only if requested and is a valid phone number
        local(f) = string   // formatted output
        local(d) = 1    // digit index position
        with i in #format -> split('') do {
            if(#d <= #number -> size) => {
                if(#i == '#') => {
                    // append a digit from #number to the formatted number
                    // as long as there are digits left to extract from #number
                    #f -> append(#number -> substring(#d, 1))
                    #d += 1
                else
                    // append the character to the formatted number
                    #f -> append(#i)
                }
            }
        }
        return(#f)
    else
        // else just return whether the number is valid
        return(#v)
    }
}
/*

// tests
local(n) = '415-555-5555'
// local(n) = bytes('1234567890')
local(n) = '800-456-7890x12'
local(n) = '800-456-7890x1234'
'<br>'
#n = string(#n)
'<br>'
'number only: '
valid_nanp(-number=#n)
'<br>'
'with format: '
valid_nanp(-number=#n, -format='(###) ###-#### x###')
'<br>'
#n
 */
?>
