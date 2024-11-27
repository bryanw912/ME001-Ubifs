attrs :
{
    idVendor = 0x3231;
    idProduct = 0x0630;
    bcdDevice = 0x0091;
};
strings = (
    {
        lang = 0x409;
        manufacturer = "Kneron";
        product = "Kneron KL630";
        serialnumber = "TBD";
    }
);
functions :
{
    plus =
    {
        instance = "plus";
        type = "ffs"
    };
};
configs = (
    {
        id = 1;
        name = "c";
        strings = ({
            lang = 0x409
            configuration = "The only one"
        })
        functions = ("plus")
    }
);
