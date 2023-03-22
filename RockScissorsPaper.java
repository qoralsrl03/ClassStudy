import java.util.Scanner;

public class RockScissorsPaper {
	public static int RSP() {
		int j = 0;
		j = (int) (Math.random() * 3);
		return j;
	}

	public static void RSPvsSCAN(int x, int y) {
		if (x == y) {
			System.out.println("비겼습니다.");
		} else if (x == 0) {
			if (y == 1) {
				System.out.println("졌습니다.(Computer = 바위)");
			} else if (y == 2) {
				System.out.println("이겼습니다.(Computer = 보)");
			}
		} else if (x == 1) {
			if (y == 0) {
				System.out.println("이겼습니다.(Computer = 가위)");
			} else if (y == 2) {
				System.out.println("졌습니다.(Computer = 보)");
			}
		} else if(x==2){
			if (y == 0) {
				System.out.println("졌습니다.(Computer = 가위)");
			} else if (y == 1) {
				System.out.println("이겼습니다.(Computer = 바위)");
			}
		}else {System.out.println("시스템 오류");}

	}

	public static int Scan() {
		String handle = "";
		int n = 0;
		System.out.println("값을 입력하세요(가위, 바위, 보): ");
		Scanner scan = new Scanner(System.in);
		handle = scan.nextLine();
		if ("가위".equals(handle)) {
			n = 0;
		} else if ("바위".equals(handle)) {
			n = 1;
		} else {
			n = 2;
		}
		return n;
	}
   public static void Stop() {
	   int com=0; 
		int my=0;
		int stop =0;
		String continues = "";
		Scanner scan = new Scanner(System.in);
	   while(true) {
			my = Scan();
			com = RSP();
			RSPvsSCAN(my, com);
			System.out.println("계속하시려면 Y/아니면 N");
			continues = scan.next();
			if("N".equals(continues)) {
				break;
			}
			else {continue;}
	   }
   }
	public static void main(String[] args) {
		System.out.println("가위바위보의 세계에 오신것을 환영합니다.");
		Stop();
	}
}
