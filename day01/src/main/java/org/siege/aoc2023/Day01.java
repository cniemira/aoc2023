/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package org.siege.aoc2023;

import java.io.*;

/**
 *
 * @author cniemira
 */
public class Day01 {
    public void part1 (String requestedFile)
    {
        Integer mySum = 0;
        Integer myInt;
        Integer myTens;
        Integer myOnes;
        String myInputFile;
        String myLine;
        
        if (requestedFile == null)
        {
          myInputFile = new String("01_1_input.txt");            
          myInputFile = this.getClass().getClassLoader().getResource(myInputFile).getFile();
        } else {
          myInputFile = requestedFile;  
        }

        try {
            FileReader myReader = new FileReader(myInputFile);
            BufferedReader myBuffer = new BufferedReader(myReader);

            while (myBuffer.ready())
            {
                myLine = myBuffer.readLine();

                myTens = null;
                myOnes = null;
                
                for (int i = 0; i < myLine.length(); i++)
                {
                    myInt = Integer.valueOf(myLine.charAt(i));
                    if (58 > myInt & myInt > 47)
                    {
                        myInt -= 48;
                        if (myTens == null)
                        {
                            myTens = myInt;
                            myOnes = myInt;
                        }
                        else
                        {
                            myOnes = myInt;
                        }
                    }
                }
                
                myInt = myTens*10 + myOnes;
                mySum += myInt;
                
                System.out.println(myInt);
            }
            myReader.close();
        }
        catch (IOException e)
        {
            System.out.println(e);
        }

        System.out.println(mySum);
        
    }
 
    public void part2 (String requestedFile)
    {
        String myInputFile;
        String myLine;
        String myOutputFile = new String("01_2_output.txt");

        if (requestedFile == null)
        {
          myInputFile = new String("01_1_input.txt");            
        } else {
          myInputFile = requestedFile;  
        }

        myInputFile = this.getClass().getClassLoader().getResource(myInputFile).getFile();
        myOutputFile = this.getClass().getClassLoader().getResource(myOutputFile).getFile();

        try {
            FileReader myReader = new FileReader(myInputFile);
            BufferedReader myBufferedReader = new BufferedReader(myReader);

            FileWriter myWriter = new FileWriter(myOutputFile);
            BufferedWriter myBufferedWriter = new BufferedWriter(myWriter);

            while (myBufferedReader.ready())
            {
                myLine = myBufferedReader.readLine();

                if (myLine.contains("one")) {
                    myLine = myLine.replace("one", "one1one");
                }
                if (myLine.contains("two")) {
                    myLine = myLine.replace("two", "two2two");
                }
                if (myLine.contains("three")) {
                    myLine = myLine.replace("three", "three3three");
                }                   
                if (myLine.contains("four")) {
                    myLine = myLine.replace("four", "four4four");
                }
                if (myLine.contains("five")) {
                    myLine = myLine.replace("five", "five5five");
                }
                if (myLine.contains("six")) {
                    myLine = myLine.replace("six", "six6six");
                }
                if (myLine.contains("seven")) {
                    myLine = myLine.replace("seven", "seven7seven");
                }
                if (myLine.contains("eight")) {
                    myLine = myLine.replace("eight", "eight8eight");
                }                   
                if (myLine.contains("nine")) {
                    myLine = myLine.replace("nine", "nine9nine");
                }
    
                System.out.println(myLine);
                myBufferedWriter.write(myLine + "\n");

            }
            
            myBufferedReader.close();
            myBufferedWriter.close();
            
            this.part1(myOutputFile);
        }
        catch (Exception e)
        {
            System.out.println(e);
        }
    }
    
}
