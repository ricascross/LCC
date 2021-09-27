import java.util.Arrays;
public class Ficha2 {
    public int minimo(int[] array){
        int min = Integer.MAX_VALUE;
        for(int v:array)
            if (v<min)
                min = v;
        return min;
    }

    public int[] arrayNovo (int[] array, int indice1, int indice2){

        return Arrays.copyOfRange(array,indice1,indice2);
    }

    public int[] arrayComElementosComuns(int[] array1,int[] array2){
        int[] newArray = new int[array1.length];
        int j = 0;
        for(int ia=0;ia < array1.length;ia++)
            for(int ib=0; ib < array2.length;ib++)
                if(array1[ia]==array2[ib]){
                    newArray[j++] = array1[ia];
                    ib = array2.length;
                }

        return newArray;
    }


}
