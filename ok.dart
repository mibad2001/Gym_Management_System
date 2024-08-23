import 'dart:io';

class Time {
  int hour;
  int minute;

  Time(this.hour, this.minute);

  @override
  String toString() {
    String formattedHour = hour < 10 ? '0$hour' : '$hour';
    String formattedMinute = minute < 10 ? '0$minute' : '$minute';
    return '$formattedHour:$formattedMinute';
  }
}


class Member {
  String id;
  String name;
  int age;
  String address;
  String membershipType;
  DateTime startDate;

  Member(this.id, this.name, this.age, this.address, this.membershipType, this.startDate);

  void updateInfo(String newAddress, String newMembershipType) {
    address = newAddress;
    membershipType = newMembershipType;
    print("Member info updated.");
  }

  void viewProfile() {
    print("Member ID: $id\nName: $name\nAge: $age\nAddress: $address\nMembership: $membershipType\nStart Date: $startDate");
  }
}


class Trainer {
  String id;
  String name;
  String specialty;
  List<Time> availability;

  Trainer(this.id, this.name, this.specialty, this.availability);

  void viewSchedule() {
    print("Trainer: $name, Specialty: $specialty");
    for (var time in availability) {
      print("Available at: ${time.toString()}");
    }
  }

  void updateInfo(String newSpecialty, List<Time> newAvailability) {
    specialty = newSpecialty;
    availability = newAvailability;
    print("Trainer info updated.");
  }
}


class GymClass {
  String id;
  String name;
  Time schedule;
  int duration;
  Trainer trainer;

  GymClass(this.id, this.name, this.schedule, this.duration, this.trainer);

  void assignTrainer(Trainer newTrainer) {
    trainer = newTrainer;
    print("Trainer assigned to class: $name");
  }

  void updateClassDetails(Time newSchedule, int newDuration) {
    schedule = newSchedule;
    duration = newDuration;
    print("Class details updated.");
  }

  void viewClassDetails() {
    print("Class ID: $id\nClass Name: $name\nSchedule: ${schedule.toString()}\nDuration: $duration minutes\nTrainer: ${trainer.name}");
  }
}

class Payment {
  String paymentId;
  Member member;
  double amount;
  DateTime paymentDate;

  Payment(this.paymentId, this.member, this.amount, this.paymentDate);

  void processPayment() {
    print("Payment processed for Member: ${member.name}, Amount: \$${amount}, Date: $paymentDate");
  }

  String generateInvoice() {
    return "Invoice: Payment ID: $paymentId, Member: ${member.name}, Amount: \$${amount}, Date: $paymentDate";
  }
}

class Gym {
  List<Member> members = [];
  List<Trainer> trainers = [];
  List<GymClass> classes = [];
  List<Payment> payments = [];

  void addMember(Member member) {
    members.add(member);
    print("Member added: ${member.name}");
  }

  void addTrainer(Trainer trainer) {
    trainers.add(trainer);
    print("Trainer added: ${trainer.name}");
  }

  void addClass(GymClass gymClass) {
    classes.add(gymClass);
    print("Class added: ${gymClass.name}");
  }

  void processPayment(Payment payment) {
    payments.add(payment);
    payment.processPayment();
  }

  void updateMember(String memberId) {
    try {
      var member = members.firstWhere((m) => m.id == memberId);
      print("Enter new address:");
      String address = stdin.readLineSync()!;
      print("Enter new membership type:");
      String membershipType = stdin.readLineSync()!;
      member.updateInfo(address, membershipType);
    } catch (e) {
      print("Member not found.");
    }
  }

  void updateTrainer(String trainerId) {
    try {
      var trainer = trainers.firstWhere((t) => t.id == trainerId);
      print("Enter new specialty:");
      String specialty = stdin.readLineSync()!;
      print("Enter new availability (comma-separated hours, e.g., '09:00,13:00'):");
      List<Time> availability = stdin.readLineSync()!.split(',').map((time) {
        List<String> parts = time.split(':');
        return Time(int.parse(parts[0]), int.parse(parts[1]));
      })
          .toList();
      trainer.updateInfo(specialty, availability);
    } catch (e) {
      print("Trainer not found.");
    }
  }

  void viewMembers() {
    for (var member in members) {
      member.viewProfile();
    }
  }

  void viewTrainers() {
    for (var trainer in trainers) {
      trainer.viewSchedule();
    }
  }

  void viewClasses() {
    for (var gymClass in classes) {
      gymClass.viewClassDetails();
    }
  }

  void viewPayments() {
    for (var payment in payments) {
      print(payment.generateInvoice());
    }
  }
}


 String _adminUsername = 'admin';
 String _adminPassword = '12345';


bool adminLogin() {
  print("Enter admin username:");
  String username = stdin.readLineSync()!;
  print("Enter admin password:");
  String password = stdin.readLineSync()!;
  return username == _adminUsername && password == _adminPassword;
}


void main() {
  Gym gym = Gym();

  if (adminLogin()) {
    print("Login successful!");
    while (true) {
      print("\n--- Gym Management System ---");
      print("1. Add Member");
      print("2. Add Trainer");
      print("3. Add Class");
      print("4. Update Member");
      print("5. Update Trainer");
      print("6. View Members");
      print("7. View Trainers");
      print("8. View Classes");
      print("9. Process Payment");
      print("10. View Payments");
      print("0. Exit");
      print("Enter your choice:");

      String choice = stdin.readLineSync()!;
      switch (choice) {
        case '1':

          print("Enter member ID:");
          String memberId = stdin.readLineSync()!;
          print("Enter member name:");
          String memberName = stdin.readLineSync()!;
          print("Enter member age:");
          int age = int.parse(stdin.readLineSync()!);
          print("Enter member address:");
          String address = stdin.readLineSync()!;
          print("Enter membership type:");
          String membershipType = stdin.readLineSync()!;
          gym.addMember(Member(memberId, memberName, age, address, membershipType, DateTime.now()));
          break;

        case '2':

          print("Enter trainer ID:");
          String trainerId = stdin.readLineSync()!;
          print("Enter trainer name:");
          String trainerName = stdin.readLineSync()!;
          print("Enter trainer specialty:");
          String specialty = stdin.readLineSync()!;
          print("Enter availability (comma-separated hours, e.g., '09:00,13:00'):");
          List<Time> availability = stdin.readLineSync()!.split(',').map((time) {
            List<String> parts = time.split(':');
            return Time(int.parse(parts[0]), int.parse(parts[1]));}).toList();
          gym.addTrainer(Trainer(trainerId, trainerName, specialty, availability));
          break;

        case '3':

          print("Enter class ID:");
          String classId = stdin.readLineSync()!;
          print("Enter class name:");
          String className = stdin.readLineSync()!;
          print("Enter schedule time (HH:MM):");
          List<String> scheduleParts = stdin.readLineSync()!.split(':');
          Time schedule = Time(int.parse(scheduleParts[0]), int.parse(scheduleParts[1]));
          print("Enter duration (in minutes):");
          int duration = int.parse(stdin.readLineSync()!);
          print("Enter trainer ID:");
          String assignedTrainerId = stdin.readLineSync()!;
          Trainer? assignedTrainer = gym.trainers.firstWhere((t) => t.id == assignedTrainerId,
            orElse: () => throw ArgumentError("Trainer not found."),
          );
          gym.addClass(GymClass(classId, className, schedule, duration, assignedTrainer));
          break;

        case '4':
        // Update Member
          print("Enter member ID to update:");
          String updateMemberId = stdin.readLineSync()!;
          gym.updateMember(updateMemberId);
          break;

        case '5':

          print("Enter trainer ID to update:");
          String updateTrainerId = stdin.readLineSync()!;
          gym.updateTrainer(updateTrainerId);
          break;

        case '6':

          gym.viewMembers();
          break;

        case '7':

          gym.viewTrainers();
          break;

        case '8':

          gym.viewClasses();
          break;

        case '9':

          print("Enter payment ID:");
          String paymentId = stdin.readLineSync()!;
          print("Enter member ID:");
          String memberId = stdin.readLineSync()!;
          Member? member = gym.members.firstWhere(
                (m) => m.id == memberId,
            orElse: () => throw ArgumentError("Member not found."),
          );
          print("Enter amount:");
          double amount = double.parse(stdin.readLineSync()!);
          gym.processPayment(Payment(paymentId, member, amount, DateTime.now()));
          break;

        case '10':

          gym.viewPayments();
          break;

        case '0':
        
          print("Exiting...");
          return;

        default:
          print("Invalid choice. Please try again.");
      }
    }
  } else {
    print("Login failed. Exiting...");
  }
}
