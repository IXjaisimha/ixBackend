package Assignment1;
import java.util.Scanner;
class Employee{
    int id;
    String name;
    double montlySalary;
    static String companyName="Innovatechs";
    
    Employee(int id, String name, double montlySalary){
        this.id=id;
        this.name=name;
        this.montlySalary=montlySalary;
    }

    void displayDetails(){
        System.out.println("Employee ID: " + this.id);
        System.out.println("Employee Name: " + this.name);
        System.out.println("Monthly Salary: " + this.montlySalary);
        System.out.println("Company Name: " + companyName);
    }

    public double getAnnualSalary(){
        return this.montlySalary * 12;
    }

}
public class program5 {
    public static void main(String[] args){
        Scanner sc=new Scanner(System.in);
        
        System.out.print("Enter Employee ID: ");
        int id=sc.nextInt();            
        sc.nextLine(); // consume newline
        System.out.print("Enter Employee Name: ");  
        String name=sc.nextLine();
        System.out.print("Enter Monthly Salary: ");     
        double montlySalary=sc.nextDouble();

        Employee emp=new Employee(id, name, montlySalary);
        System.out.println("==============================");

        System.out.println("Employee Details:");
        emp.displayDetails();
        System.out.println("==============================");
        System.out.println("Annual Salary: " + emp.getAnnualSalary());
        
        sc.close();
    }
}
