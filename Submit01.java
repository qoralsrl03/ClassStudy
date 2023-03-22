package minki.submit01;

public class Submit01 {

	public static void main(String[] args) {
		// Q.01
		String name = "백민기";
		int age = 27;
		double height = 168.0;
		String phone = "010-7406-4815";
		String email = "qoralsrl03@naver.com";

		System.out.println("이름 : " + name + "\n" + "나이 : "+age + "\n" + "키 : " + height + "\n" + "전화번호 : " +
				phone + "\n" + "이메일 : " + email + "\n");

		// Q.02
		String enigma = "너오구늘리뭐너먹구지리";
		enigma = enigma.replace("너", "");
		System.out.println("1차 암호 해독[너 제거]: " + enigma);
		enigma = enigma.replace("구","");
		System.out.println("2차 암호 해독[구 제거]: " + enigma);
		enigma = enigma.replace("리","");
		System.out.println("3차 암호 해독[리 제거]: " + enigma);
		System.out.println("해독완료!! -> " + enigma);
		System.out.println(enigma + "\n");

		//Q.03
		int example = 278;
		int add = 0;
		for(int i=0; i<3; i++) {
			add += example % 10;
			example = example/10;
		}
		System.out.println("결과는 : " + add);
	}

}
