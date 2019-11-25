#import remi.gui as gui
from remi import start, App
from remi.gui import *
import json
import subprocess

class Generator(App):
    def __init__(self, *args):
        super(Generator, self).__init__(*args)

    def main(self):
        window1 = Widget()
        window1.attributes.update({"editor_baseclass":"Widget","editor_tag_type":"widget","editor_newclass":"False","editor_constructor":"()","class":"Widget","editor_varname":"window1"})
        window1.style.update({"position":"absolute","margin":"0px","overflow":"auto","top":"20px","left":"20px","width":"340.0px","height":"420.0px"})
        
        def createLabel(win, name, index, w=100, h=25 ):
            topstr = str(10+ index * 30)
            widthstr = str(w)
            heightstr = str(h)
            lblstr = "lbl"+str(index)
            lbl1 = Label(name)
            #lbl1.attributes.update({"editor_baseclass":"Label","editor_tag_type":"widget","editor_newclass":"False","editor_constructor":"('Smart contract address')","class":"Label","editor_varname":"lbl1"})
            lbl1.style.update({"position":"absolute","margin":"0px","overflow":"auto","top":topstr+".0px","left":"10.0px","width":widthstr+".0px","height":heightstr+".0px"})
            win.append(lbl1,lblstr)
        
        def createLabelPos(win, namevar, x,y,w,h):
            leftstr = str(x)
            topstr = str(y)
            widthstr = str(w)
            heightstr = str(h)
            lbl1 = Label("log:")
            #lbl1.attributes.update({"editor_baseclass":"Label","editor_tag_type":"widget","editor_newclass":"False","editor_constructor":"('Smart contract address')","class":"Label","editor_varname":"lbl1"})
            lbl1.style.update({"position":"absolute","margin":"0px","overflow":"auto","top":topstr+".0px","left":leftstr+".0px","width":widthstr+".0px","height":heightstr+".0px"})
            win.append(lbl1,namevar)
        
        def createText(win, index, w = 200, h = 25, sline = True):
            topstr = str(10+ index * 30)
            widthstr = str(w)
            heightstr = str(h)
            txtstr = "txt"+str(index)
            txt1 = TextInput(sline,'')
            #txt1.attributes.update({"editor_newclass":"False","editor_baseclass":"TextInput","editor_constructor":"(False,'')","class":"TextInput","autocomplete":"off","editor_tag_type":"widget","editor_varname":"txt1"})
            txt1.style.update({"position":"absolute","margin":"1px","overflow":"auto","top":topstr+".0px","left":"110.0px","width":widthstr+".0px","height":heightstr+".0px"})
            window1.append(txt1,txtstr)
        
        def createBtn(win, caption, index, cmdstr, x=10,y=10, w=100, h = 25):
            leftstr = str(x)
            topstr = str(y)
            widthstr = str(w)
            heightstr = str(h)
            btnstr = "btn"+str(index)
            btn1 = Button(caption)
            btn1.style.update({"position":"absolute","margin":"0px","overflow":"auto","top":topstr+".0px","left":leftstr+".0px","width":widthstr+".0px","height":heightstr+".0px"})
            btn1.onclick.do(cmdstr)
            window1.append(btn1,btnstr)
        
        createText(window1, 0, 100)
        createBtn(window1,"Load",0,self.on_button_pressed,200,10,100,50)
        createLabel(window1,"Forum name",1)
        createLabelPos(window1,"-",200,10,100,50)
        createLabel(window1,"Admins",2)
        createText(window1, 2, 100)
        
        createText(window1, 1, 100)
        createLabel(window1,"Sender name",0)
        createLabel(window1,"Recipient name",1)
        createLabelPos(window1,"lblresult",10,240,300,60)
        createBtn(window1,"Click me",3,self.on_button_pressed,10,240,300,60)
        
        '''
        btnGenAcc = Button('Generate')
        #btnGenAcc.attributes.update({"editor_baseclass":"Button","editor_tag_type":"widget","editor_newclass":"False","editor_constructor":"('Add User')","class":"Button","editor_varname":"btnGenAcc"})
        btnGenAcc.style.update({"position":"absolute","margin":"0px","overflow":"auto","top":"200.0px","left":"10.0px","width":"100px","height":"30px"})
        btnGenAcc.onclick.do(self.on_button_pressed)
        window1.append(btnGenAcc,'btnGenAcc')
        '''
        '''
        createLabel(window1,"AES key",10)
        createText(window1, 10)
        createLabel(window1,"Shared Config",11)
        createText(window1, 11)
        '''
        
        #btnShare = Button('Share It')
        #btnShare.style.update({"position":"absolute","margin":"0px","overflow":"auto","top":"380.0px","left":"10.0px","width":"100px","height":"30px"})
        #btnShare.onclick.do(self.on_button_pressed2)
        #window1.append(btnShare,'btnShare')
        
        #link1 = Link("http://localhost:8081", "A link to here", width=200, height=30, margin='10px')
        #window1.append(link1,'link1')
        
        #self.slider = gui.Slider(10, 0, 100, 5, width=200, height=20, margin='10px')
        #self.slider.onchange.do(self.slider_changed)
        
        #items = ('Danny Young','Christine Holand','Lars Gordon','Roberto Robitaille')
        #self.listView = gui.ListView.new_from_list(items, width=300, height=120, margin='10px')
        #self.listView.onselection.do(self.list_view_on_selected)
        
        self.window1 = window1
        #self.window1.children['txt10'].set_text("passworddariAkeC")
        #self.window1.children['txt11'].set_text("Config_accA_accC.dat")
        return self.window1

    # listener function
    def on_button_pressed(self, widget):
        #generate the accounts
        self.window1.children['txt0'].set_text("Click me")
        
    def on_button_pressed2(self, widget):
        self.window1.children['txt0'].set_text("Click me2")
        
# starts the web server
start(Generator)
