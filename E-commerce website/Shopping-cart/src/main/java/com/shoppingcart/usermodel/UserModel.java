package com.shoppingcart.usermodel;

import java.util.Objects;

public class UserModel {
    private int id;
    private String first_name;  // Field for the user's first name
    private String last_name;   // Field for the user's last name
    private String email;
    private String password;
    private String phone_number; // Field for the user's phone number
    private String address;      // Field for the user's address
    private String city;
    private String state;
    private String zip_code;

    // Default constructor
    public UserModel() {
    }

    // Parameterized constructor
    public UserModel(int id, String first_name, String last_name, String email, String password, String phone_number, String address, String city, String state, String zip_code) {
        this.id = id;
        this.first_name = first_name;
        this.last_name = last_name;
        this.email = email;
        this.password = password;
        this.phone_number = phone_number;
        this.address = address;
        this.city = city;
        this.state = state;
        this.zip_code = zip_code;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getFirstName() {
        return first_name;
    }

    public void setFirstName(String first_name) {
        if (first_name != null && !first_name.trim().isEmpty()) {
            this.first_name = first_name;
        } else {
            throw new IllegalArgumentException("First name cannot be null or empty");
        }
    }

    public String getLastName() {
        return last_name;
    }

    public void setLastName(String last_name) {
        if (last_name != null && !last_name.trim().isEmpty()) {
            this.last_name = last_name;
        } else {
            throw new IllegalArgumentException("Last name cannot be null or empty");
        }
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        if (email != null && email.matches("^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$")) {
            this.email = email;
        } else {
            throw new IllegalArgumentException("Invalid email format");
        }
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        if (password != null && !password.trim().isEmpty()) {
            this.password = password;
        } else {
            throw new IllegalArgumentException("Password cannot be null or empty");
        }
    }

    public String getPhoneNumber() {
        return phone_number;
    }

    public void setPhoneNumber(String phone_number) {
        if (phone_number != null && phone_number.matches("^\\+?[0-9]{10,15}$")) {
            this.phone_number = phone_number;
        } else {
            throw new IllegalArgumentException("Invalid phone number");
        }
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        if (address != null && !address.trim().isEmpty()) {
            this.address = address;
        } else {
            throw new IllegalArgumentException("Address cannot be null or empty");
        }
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        if (city != null && !city.trim().isEmpty()) {
            this.city = city;
        } else {
            throw new IllegalArgumentException("City cannot be null or empty");
        }
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        if (state != null && !state.trim().isEmpty()) {
            this.state = state;
        } else {
            throw new IllegalArgumentException("State cannot be null or empty");
        }
    }

    public String getZipCode() {
        return zip_code;
    }

    public void setZipCode(String zip_code) {
        if (zip_code != null && !zip_code.trim().isEmpty()) {
            this.zip_code = zip_code;
        } else {
            throw new IllegalArgumentException("Zip code cannot be null or empty");
        }
    }

    @Override
    public String toString() {
        return "UserModel{" +
                "id=" + id +
                ", first_name='" + first_name + '\'' +
                ", last_name='" + last_name + '\'' +
                ", email='" + email + '\'' +
                ", password='" + password + '\'' +
                ", phone_number='" + phone_number + '\'' +
                ", address='" + address + '\'' +
                ", city='" + city + '\'' +
                ", state='" + state + '\'' +
                ", zip_code='" + zip_code + '\'' +
                '}';
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        if (obj == null || getClass() != obj.getClass()) return false;
        UserModel that = (UserModel) obj;
        return id == that.id &&
                Objects.equals(first_name, that.first_name) &&
                Objects.equals(last_name, that.last_name) &&
                Objects.equals(email, that.email) &&
                Objects.equals(password, that.password) &&
                Objects.equals(phone_number, that.phone_number) &&
                Objects.equals(address, that.address) &&
                Objects.equals(city, that.city) &&
                Objects.equals(state, that.state) &&
                Objects.equals(zip_code, that.zip_code);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, first_name, last_name, email, password, phone_number, address, city, state, zip_code);
    }
}
