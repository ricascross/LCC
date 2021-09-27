package Exceptions;


/**
 * Write a description of class NaoExisteHotel here.
 *
 * @author (your name)
 * @version (a version number or a date)
 */
public class NaoExisteHotel extends Exception
{
    public NaoExisteHotel(){super();}
    public NaoExisteHotel(String msg){super(msg);}
}
