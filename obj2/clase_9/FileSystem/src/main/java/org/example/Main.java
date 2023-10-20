package org.example;

public class Main {
    public static void main(String[] args) {
        Directory fd = new Directory("main");
        Directory fd2 = new Directory("main2");
        Directory fd3 = new Directory("main3");
        Directory fd4 = new Directory("main4");
        Directory fd5 = new Directory("main5");
        fd.addElement(fd2);
        fd.addElement(fd3);
        fd.addElement(fd4);
        fd5.addElement(new File(20, "file1.jpg"));
        fd5.addElement(new File(20, "file2.jpg"));
        fd4.addElement(new File(20, "file3.jpg"));
        fd4.addElement(new File(20, "file4.jpg"));
        fd4.addElement(fd5);
        fd2.addElement(new File(20, "file5.jpg"));
        fd.printStructure("");
        System.out.println("OBJECT NAME = " + fd.oldestElement().getName());
    }
}