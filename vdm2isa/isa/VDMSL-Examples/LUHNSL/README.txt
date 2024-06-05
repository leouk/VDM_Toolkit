Author: Nick Battle


Luhn algorithm
See http://en.wikipedia.org/wiki/Luhn_algorithm

The Luhn algorithm or Luhn formula, also known as the "modulus 10" or "mod 10" algorithm, is a simple
checksum formula used to validate a variety of identification numbers, such as credit card numbers,
IMEI numbers, National Provider Identifier numbers in US and Canadian Social Insurance Numbers. It was
created by IBM scientist Hans Peter Luhn and described in U.S. Patent No. 2,950,048, filed on
January 6, 1954, and granted on August 23, 1960.

The algorithm is in the public domain and is in wide use today. It is specified in ISO/IEC 7812-1.[1]
It is not intended to be a cryptographically secure hash function; it was designed to protect against
accidental errors, not malicious attacks. Most credit cards and many government identification numbers
use the algorithm as a simple method of distinguishing valid numbers from collections of random digits.

Language Version: vdm10
Entry point     : LUHN`luhn([1,2,3,4,5])
Entry point     : LUHN`luhns("12345")
Entry point     : LUHN`luhnn(12345)