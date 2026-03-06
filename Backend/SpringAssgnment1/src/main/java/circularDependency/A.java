package circularDependency;

public class A {

    private B b;

    public void setB(B b) {
        this.b = b;
    }

    public A() {
        System.out.println("A created");
    }

//    public A(B b) {
//        this.b = b;
//        System.out.println("A created");
//    }
}