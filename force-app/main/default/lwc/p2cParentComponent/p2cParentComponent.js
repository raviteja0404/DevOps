import { LightningElement } from 'lwc';

export default class P2cParentComponent extends LightningElement {

    CaursalData = [ 
        {
        number: 1,
       // src : "https://www.lightningdesignsystem.com/assets/images/carousel/carousel-01.jpg",
        header : "First Card 1",
        description : "First card description.",
        alternativetext : "First card accessible description."               
    },
    {
        number: 2,
       // src : "https://www.lightningdesignsystem.com/assets/images/carousel/carousel-02.jpg",
        header : "Second Card 2",
        description : "Second card description.",
        alternativetext : "Second card accessible description."               
    },
    {
        number: 3,
       //src : "https://www.lightningdesignsystem.com/assets/images/carousel/carousel-03.jpg",
        header : "Third Card 3",
        description : "Third card description.",
        alternativetext : "Third card accessible description."               
    }

]
}