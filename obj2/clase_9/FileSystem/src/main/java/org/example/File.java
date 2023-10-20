package org.example;

import java.util.Calendar;
import java.util.Date;

public class File implements FileSystem, Comparable<File> {
    private Date creation;
    private Date lastModification;
    private int size;
    private String name;

    public File(int size, String name) {
        this.size = size;
        this.name = name;
        Calendar calendar = Calendar.getInstance();
        this.creation = calendar.getTime();
        this.lastModification = calendar.getTime();
    }

    public Date getCreation() {
        return creation;
    }

    public Date getLastModification() {
        return lastModification;
    }

    public String getName() {
        return name;
    }

    @Override
    public int totalSize() {
        return size;
    }

    public void modify() {
        this.lastModification = Calendar.getInstance().getTime();
    }

    public Date getLastModificationTime() {
        return this.lastModification;
    }

    @Override
    public void printStructure(String identation) {
        System.out.println(name);
    }

    @Override
    public File lastModified() {
        return this;
    }

    @Override
    public File oldestElement() {
        return this;
    }

    @Override
    public int compareTo(File otherFile) {
        return creation.compareTo(otherFile.creation);
    }
}
