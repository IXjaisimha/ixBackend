import java.util.*;
import java.util.logging.*;

class InvalidAgeException extends Exception {
    public InvalidAgeException(String message) {
        super(message);
    }
}

class InvalidEmailException extends Exception {
    public InvalidEmailException(String message) {
        super(message);
    }
}

class InvalidUsernameException extends Exception {
    public InvalidUsernameException(String message) {
        super(message);
    }
}

public class program3 {
    public static final Logger logger = Logger.getLogger(program3.class.getName());

    public void validateAge(int age) throws InvalidAgeException {
        if (age < 18 || age > 60) {
            throw new InvalidAgeException("Age must be between 18 and 60.");
        } else {
            System.out.println("Age is valid: " + age);
        }
    }

    public void validateEmail(String email) throws InvalidEmailException {
        String emailRegex = "^(?!.*\\.{2})[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$";
        if (!email.matches(emailRegex)) {
            throw new InvalidEmailException("Invalid email: " + email);
        } else {
            System.out.println("Email is valid: " + email);
        }
    }

    public void validateUsername(String username) throws InvalidUsernameException {
        String usernameRegex = "^[a-zA-Z0-9._-]{5,15}$";
        if (!username.matches(usernameRegex)) {
            throw new InvalidUsernameException("Invalid username: " + username);
        } else {
            System.out.println("Username is valid: " + username);
        }
    }
    public static void main(String[] args) {
        logger.info("Program started");
        program3 validator = new program3();
        Scanner scanner = new Scanner(System.in);
        int n = 1;
        while(n!=0){
            System.out.println("Enter Empolyee Info : Name, Age, Email, Username");
        
            String name = scanner.nextLine();
            int age = scanner.nextInt();    
            scanner.nextLine(); 
            String email = scanner.nextLine();
            String username = scanner.nextLine();
            boolean isValid = true;
            try{
                try {
                    validator.validateAge(age);
                } catch (InvalidAgeException e) {
                    isValid = false;
                    logger.severe("Age validation failed: " + e.getMessage());
                }
                try {
                    validator.validateEmail(email);
                    } 
                catch (InvalidEmailException e) {
                    isValid = false;
                    logger.severe("Email validation failed: " + e.getMessage());
                }
                try {
                    validator.validateUsername(username);
                } catch (InvalidUsernameException e) {
                    isValid = false;
                    logger.severe("Username validation failed: " + e.getMessage());
                }
                if(isValid){
                    logger.info("Employee " + name + " with age " + age + " and email " + email + " is valid.");
                    break;
                } else {
                    logger.warning("Employee " + name + " has invalid details.");
                }
            } catch (Exception e) {
                logger.severe("An unexpected error occurred: " + e.getMessage());
            }
        }
        logger.info("Program ended");


        scanner.close();

    }
}
