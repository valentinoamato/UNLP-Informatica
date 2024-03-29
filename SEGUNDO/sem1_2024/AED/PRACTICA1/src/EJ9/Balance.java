package EJ9;

public class Balance {
	
	private static boolean contains(char[] array, char c) {
		boolean result = false;
		
		for (char e : array) {
			if (e==c) {
				result = true;
				break;
			}
		}
		
		return result;
	}
	
	public static boolean isBalanced(String string) {
		char[] carray =  string.toCharArray();
		char[] openChars = {'(','{','['};
		int i;
		Stack<Character> stack = new Stack<Character>(carray.length);
		
		
		if (carray.length % 2 != 0 ) {
			return false;
		}
		
		for (i=0;i<carray.length;i++) {
			char current =  carray[i];
			
			if (Balance.contains(openChars, current)) {
				stack.push(carray[i]);
			} else {
				char c = stack.pop();
				switch (c) {
					case '(':
						if (carray[i] != ')') return false;
						break;
					case '{':
						if (carray[i] != '}') return false;
						break;
					case '[':
						if (carray[i] != ']') return false;
						break;
					default:
						return false;
				
				}	
			}
		}
		
		return stack.isEmpty();
	}

}
