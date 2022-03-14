from machine import Pin,SPI
from hx711 import HX711
import max7219_8digit


OFFSET = 4650
GRAM_COEFF = 0.002912589


###########################################################
###               Display                           #######
###########################################################
#Intialize the SPI for the display
spi = SPI(0, baudrate=10000000, polarity=1, phase=0, sck=Pin(2), mosi=Pin(3))
ss = Pin(5, Pin.OUT)
# init the display
display = max7219_8digit.Display(spi, ss)

leftstr = "gr -"
display_str = "{}8  8".format(leftstr)
display.write_to_buffer(display_str)

def write_right(the_str):
    if len(the_str) > 4:
        the_str = the_str[:4]
    if len(the_str) < 4:
        for i in range(0,4-len(the_str)):
            the_str+=" "

    display.write_to_buffer("{}{}".format(leftstr,the_str))
    display.display()
    
# def write_left(the_str):
#     # leaves right side blank
#     if len(the_str) > 4:
#         the_str = the_str[:4]
#     if len(the_str) < 4:
#         for i in range(0,4-len(the_str)):
#             the_str+=" "
        
#     box_state['left_digits'] = the_str
#     display.write_to_buffer("{}    ".format(the_str))
#     display.display()





class scales(object):
    def __init__(self,sample_size):
        self.offset = 0
        self.coeff = GRAM_COEFF
        self.sample_size = sample_size
        
        self.checking_tare = False
        
        self.adc = HX711(d_out=14, pd_sck=15)
        
        self.find_offset()

    def read_loop(self):
        while(not self.checking_tare):
            
            raw_reading = self.adc.read()
            
            print("raw={}".format(raw_reading))
            
            grams = (raw_reading - self.offset) * self.coeff
            
            print("grams={}".format(grams))
            write_right("{:.0f}".format(grams))
            
        



    def avg_reading(self):
        sigma = 0
        
        
        for i in range(0,self.sample_size):
            sigma+= self.adc.read()
        
        avg = sigma/self.sample_size
        
        
        return( avg)


    def find_offset(self):
        self.checking_tare = True
        
        avg = self.avg_reading()
        print("offset = {}".format(avg))
        
        self.offset = avg
        self.checking_tare = False
            

    def find_coeff(self, grams):
        avg_rd = self.avg_reading()
        
        self.coeff = (grams/(avg_rd-self.offset))
        print("coeff = {}".format(self.coeff))
        
    
##################################################################
### Instantiate the scales
the_scales = scales(30)
the_scales.read_loop()




###########################################################
###             Tare Button                          #######
###########################################################
# set up tare button
tare_button = Pin(21, Pin.IN, Pin.PULL_UP)

def tare_button_callback(p):
    # the tare button has been pressed
    # first handle the debounce
    tare_button.irq(handler=None)
    
    ########## Do what needs to be done
    the_scales.find_offset()
    
    
    # now wait for the release of the button
    # wait for button to settle
    tare_button_count = 0
    while tare_button_count < 2:
        time.sleep(0.1)
        # check if button released
        if tare_button.value() == 1:
            tare_button_count+=1
            
    
    tare_button.irq(trigger=Pin.IRQ_FALLING, handler=tare_button_callback)
    the_scales.read_loop()


tare_button.irq(trigger=Pin.IRQ_FALLING, handler=tare_button_callback)


    
    
    