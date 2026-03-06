package configdemo;

public class UserService {

    private UserRepo userRepository;

    public UserService(UserRepo userRepository) {
        this.userRepository = userRepository;
    }

    public void registerUser() {
        System.out.println("UserService: Registering user...");
        userRepository.saveUser();
    }
}

