package circularDependency;

public class B {

    private A a;

    public void setA(A a) {
        this.a = a;
    }

    public B() {
        System.out.println("B created");
    }
//    public B(A a) {
//        this.a = a;
//        System.out.println("B created");
//    }
}
