package Assignment1;
import java.util.*;

class Student{
    private String Name;
    private int id;
    private int marks;

    Student(String Name,int id,int marks){
        this.Name=Name;
        this.id=id;
        this.marks=marks;
    }


    public String getName(){
        return this.Name;
    }
    public int getId(){
        return this.id;
    }   
    public int getMarks(){
        return this.marks;
    }

    public void setName(String Name){
        this.Name=Name;
    }

    public void setId(int id){
        this.id=id;
    }

    public void setMarks(int marks){
        this.marks=marks;
    }

    public void isPassed(){
        if(this.marks>=40){
            System.out.println(this.Name + " has passed the exam.");
        } else {
            System.out.println(this.Name + " has failed the exam.");
        }
    } 

    public void displayDetails(){
        System.out.println("Name: " + this.Name);
        System.out.println("ID: " + this.id);
        System.out.println("Marks: " + this.marks);
    }


}

public class program4 {
    public static void main(String[] args) {
        Scanner sc= new Scanner(System.in);
        System.out.print("Enter name of the student: ");
        String name=sc.nextLine();
        System.out.print("Enter id of student: ");  
        int id=sc.nextInt();
        System.out.print("Enter marks of student: ");
        int marks=sc.nextInt();

        Student student1 = new Student(name,id,marks);
        System.out.println("==============================");
        System.out.println("Student Details:");
        student1.displayDetails();
        System.out.println("==============================");
        System.out.println("If you want to check if the student has passed or not: enter 'yes'");
        String response = sc.next();
        if(response.equalsIgnoreCase("yes")){
            student1.isPassed();
        }
        sc.close();
    }
}
