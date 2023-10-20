package org.example;

import java.util.*;

public class Directory implements FileSystem {

    private List<FileSystem> files;
    private String name;

    public Directory(String name) {
        files = new ArrayList<>();
        this.name = name;
    }

    public void addElement(FileSystem fileSystem) {
        this.files.add(fileSystem);
    }

    @Override
    public int totalSize() {
        return files.stream().mapToInt(FileSystem::totalSize).sum();
    }

    @Override
    public void printStructure(String identation) {
        System.out.println(getName());
        files.forEach(fileSystem -> {
            System.out.print(identation + divider());
            fileSystem.printStructure(identation + "\t");
        });
    }

    private static String divider() {
        return "|___ ";
    }

    public String getName() {
        return name;
    }

    @Override
    public File lastModified() {
        Optional<File> element = files.stream()
                .map(FileSystem::lastModified)
                .filter(Objects::nonNull)
                .max(Comparator.comparing(File::getLastModificationTime));
        return element.orElse(null);
    }

    @Override
    public File oldestElement() {
        Optional<File> element = files.stream()
                .map(FileSystem::oldestElement)
                .filter(Objects::nonNull)
                .min(Comparator.comparing(File::getLastModificationTime));
        return element.orElse(null);
    }
}
