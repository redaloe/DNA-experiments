import java.io.File;
import java.io.FileWriter;
import java.io.FileNotFoundException;
import java.util.Scanner;
String current_file="Adama";
String DNA=new String();
float mutation_rate=0.1;
float frameshift_rate=0;
int codons=92;
int nucleotides=codons*3; // in nucleotides

void setup(){
  get_dna();
  size(500,500);
  background(255);
//  for(int i=0;i<4096;i++) use this when you wanna generate DNA for any reason
//    print(String.format("%1$03X",i));
}
void draw(){
  //DNA=breedFiles("Farah","Genevieve");
  //for(int i=0; i<codons;i+=3){
  //  int r=codonValue(i)%256;
  //  int g=codonValue(i+1)%256;
  //  int b=codonValue(i+2)%256;
  //  fill(r,g,b);
  
  for(int i=0;i<codons;i++){
    String[] codon=codonText(i).split("");
    int r=Integer.parseInt(codon[0],16)*16;
    int g=Integer.parseInt(codon[1],16)*16;
    int b=Integer.parseInt(codon[2],16)*16;
    fill(r,g,b);
    square(((i%16)*40)+20,(floor(i/16)*40)+20,20);
    //square(((i%10)*40)+20,(floor(i/10)*40)+20,(codonValue(i)%32)+5);
  }
  noLoop();
}

void get_dna(){
  File cur_dna= new File(current_file);
    
    try{
    println("read existing file");
    Scanner scanner= new Scanner(cur_dna);
    DNA=scanner.nextLine();
    } catch (FileNotFoundException e){ // if no dna file, create a new one
        StringBuilder s= new StringBuilder();
        for(int i=0; i<nucleotides;i++){
        s.append(Integer.toHexString(int(random(16))));
        }  
        DNA=s.toString();
        try{ 
          cur_dna.createNewFile();
          FileWriter w= new FileWriter(current_file); // is C++ this fucking tedious? i really need to try it out. or maybe i should have just made this in python
          w.write(DNA);
          w.close();
          print("created new file");
      } catch(IOException em){
          print("uh oh >_< it seems you made a fucky wucky"); 
    }
  }
}

int codonValue(int i){ // reads codons and returns them as integers. the parse int thingy is to convert hex to dec
  println(DNA.substring(i*3,i*3+3));
  return Integer.parseInt(DNA.substring(i*3,i*3+3),16);
}
String codonText(int i){ // reads codons and returns them as strings. the parse int thingy is to convert hex to dec
  println(DNA.substring(i*3,i*3+3));
  return DNA.substring(i*3,i*3+3);
}
String breed(String parent1, String parent2){ // takes two dna strings. no files
  StringBuilder child=  new StringBuilder();
  for (int i=0;i<nucleotides;i+=3){
      String codon;
      if(random(1)>0.5){
        codon=parent1.substring(i,i+3);
      }
      else{
        codon=parent2.substring(i,i+3);
      }
      if(random(1)<mutation_rate){
        if (random(1)>frameshift_rate){
        StringBuilder mutatedCodon= new StringBuilder(); // strings are immutable. instead of making codon into a stringbuilder and wasting resources, only make stringbuilder in case of mutation
        mutatedCodon.append(codon);
        mutatedCodon.setCharAt(int(random(3)),(Integer.toHexString(int(random(16))).charAt(0))); // the charAt part converts the string to char 
        codon=mutatedCodon.toString();
      }
      else{
        child.append(Integer.toHexString(int(random(16))));
      }
    }
      child.append(codon);
    }
  return child.toString();
}
String breedFiles(String file1, String file2){ // takes two filenames and breed() them
  File f1= new File(file1);
  File f2= new File(file2);
  String dna1;
  String dna2;
  try {
    Scanner s= new Scanner(f1);
    dna1= s.nextLine();
    s= new Scanner(f2);
    dna2= s.nextLine();
    println("should have breeded them");
    return breed(dna1,dna2);
    
  } catch(FileNotFoundException e){
    println("that file doesnt exist. idiot. dumbass");
    return ">_<";
  }

}
int nucToCodon(int i){
  return floor(i/3);
}
int codonToNuc(int i, int x){
  return i+x;
}
