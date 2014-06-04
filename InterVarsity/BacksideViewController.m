//
//  BacksideViewController.m
//  InterVarsity
//
//  Created by Ben Dennis on 12/8/12.
//  Copyright (c) 2012 My Mobile Fans. All rights reserved.
//

#import "BacksideViewController.h"
#import "AboutViewController.h"
#import "TraceViewController.h"
#import "SHK.h"
#import "SHKTextMessage.h"
#import "SHKTwitter.h"
#import "SHKFacebook.h"
#import "SHKMail.h"

@interface BacksideViewController ()

@end

@implementation BacksideViewController

@synthesize cardNumber, world1View, bible, frontSide, textView, showAbout, popoverController, scrollView1, scrollHeight;
@synthesize delegate;



- (BOOL)prefersStatusBarHidden {
    return YES;
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        // iOS 7
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    } else {
        // iOS 6
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    }
    
    NSArray* nibViews;
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ) {
        nibViews = [[NSBundle mainBundle] loadNibNamed:@"BacksideViewController-iPad" owner:self
                                               options:nil];
        
      
        if (cardNumber <= 6) {
            [prayButton setHidden:YES];
            [shareButton setHidden:YES];
            self.scrollHeight.constant = 676;
        }
        else {
            self.scrollHeight.constant = 611;
        }
        
        
        UIScrollView *view = [nibViews objectAtIndex:cardNumber];
        view.scrollEnabled = NO;
        [self.scrollView1 insertSubview:view atIndex:0];
        
        if (cardNumber <= 6) {
            [prayButton setHidden:YES];
            [shareButton setHidden:YES];
        }
        
        self.scrollView1.scrollEnabled = YES;
        self.scrollView1.contentSize = CGSizeMake(360.0, view.frame.size.height);
        
        //deal with bug: text doesn't show up until text view is scrolled
        switch (cardNumber) {
                
            case 1: {
                textView1.scrollEnabled = NO;
            }
                break;
            case 2:
            {
                textView2.scrollEnabled = NO;
            }
                break;
            case 3:
            {
                textView3.scrollEnabled = NO;
            }
                break;
            case 4:
            {
                textView4.scrollEnabled = NO;
            }
                break;
            case 5:
            {
                textView5.scrollEnabled = NO;
            }
                break;
            case 6:
            {
                textView6.scrollEnabled = NO;
            }
                break;
            case 7:
            {
                textView7.scrollEnabled = NO;
            }
                break;
            case 8:
            {
                textView8.scrollEnabled = NO;
            }
                break;
            default:
                break;
        }
        
        
        
    } else {
        nibViews = [[NSBundle mainBundle] loadNibNamed:@"BacksideViewController" owner:self
                                               options:nil];
        
        
        UIView *view = [nibViews objectAtIndex:cardNumber];
        [self.scrollView1 insertSubview:view atIndex:0];
        
        if (cardNumber < 5) {
            [prayButton setHidden:YES];
            [shareButton setHidden:YES];
        }
        switch (cardNumber) {
            case 1: {
                barImage.image = [UIImage imageNamed:@"bar2-iPhone@2x.png"];
                break;
            }
            case 2:
            {
                barImage.image = [UIImage imageNamed:@"bar3-iPhone@2x.png"];
            }
                break;
            case 3:
            {
                barImage.image = [UIImage imageNamed:@"bar4-iPhone@2x.png"];
            }
                break;
            case 4:
            {
                barImage.image = [UIImage imageNamed:@"bar5-iPhone@2x.png"];
            }
                break;
            case 5:
            {
                barImage.image = [UIImage imageNamed:@"bar6-iPhone@2x.png"];
            }
                break;
            case 6:
            {
                barImage.image = [UIImage imageNamed:@"bar7-iPhone@2x.png"];
            }
                break;
            case 7:
            {
                barImage.image = [UIImage imageNamed:@"bar3-iPhone@2x.png"];
            }
                break;
            case 8:
            {
                barImage.image = [UIImage imageNamed:@"bar4-iPhone@2x.png"];
            }
                break;
            case 9:
            {
                barImage.image = [UIImage imageNamed:@"bar5-iPhone@2x.png"];
                break;
            }
            case 10:
            {
                barImage.image = [UIImage imageNamed:@"bar6-iPhone@2x.png"];
            }
                break;
            default:
                break;
        }

        
        self.scrollView1.scrollEnabled = YES;
        self.scrollView1.contentSize = CGSizeMake(280.0, view.frame.size.height);
        [self.scrollView1 insertSubview:view atIndex:1];
        
    }
    /*
    switch (cardNumber) {
            
        case 1:
            barImage.image = [UIImage imageNamed:@"forGoodBar@2x.png"];
            [self hideExtraIcons];
            break;
        case 2:
            barImage.image = [UIImage imageNamed:@"damagedBar@2x.png"];
            [self hideExtraIcons];
            break;
        case 3:
            barImage.image = [UIImage imageNamed:@"restoredBar@2x.png"];
            [self hideExtraIcons];
            break;
        case 4:
            barImage.image = [UIImage imageNamed:@"sentToHealBar@2x.png"];
            [self hideExtraIcons];
            break;
        case 5:
            barImage.image = [UIImage imageNamed:@"forGoodBar@2x.png"];
            break;
        case 6:
            barImage.image = [UIImage imageNamed:@"damagedBar@2x.png"];
            break;
        case 7:
            barImage.image = [UIImage imageNamed:@"restoredBar@2x.png"];
            break;
        case 8:
            barImage.image = [UIImage imageNamed:@"sentToHealBar@2x.png"];
            break;
        default:
            break;
    }
    */
    
    // Do any additional setup after loading the view from its nib.
}


- (void) viewWillAppear:(BOOL)animated
{
    NSLog(@"%d", cardNumber);
    
    
   [self loadContent];
    
    if (cardNumber <= 6)
    {
        menuButton.hidden = YES;
        shareButton.hidden = YES;
        prayButton.hidden = YES;
    }
    else {
        shareButton.hidden = NO;
        prayButton.hidden = NO;
    }
        
}

- (void) loadContent
{
    NSString * htmlString = @"";
    
    
    switch (cardNumber)
    {
        case 1:
        {
            htmlString = [NSString stringWithFormat:@"<html> <head> <title>HTML Online Editor Sample</title> </head><style type='text/css'>body { margin:10px; padding:0; } p{margin:10px;} body { color:white; font-family:Trebuchet MS; font-size:14px; } a { color:#ff8c00; }</style> <body> <p> <span>When you turn on the news, what do you see? Racism, terrorism, global warming&hellip;the list goes on and on.</span></p> <p> <span>It&rsquo;s obvious our world is messed up.</span></p> <p> <span>But what&rsquo;s more revealing is the human response: How do you feel about this kind of world?</span></p> <p> <span>None of us think that suffering, violence, and oppression are good things. <strong>We all ache for a better world.</strong></span></p> <p><span>So what does this mean?</span></p> <p> <span>Just like hunger points to the existence of food, and thirst highlights the reality of water, our ache for a better world seems to point to the possibility that either a better world did exist or that it will one day. </span></p> </body> </html>"];
            
            break;
        }
        case 2:
        {
            htmlString = [NSString stringWithFormat:@"<html><head><title>HTML Online Editor Sample</title></head><style type='text/css'>body { margin:10px; padding:0; } p{margin:10px;} body { color:white; font-family:Trebuchet MS; font-size:14px; } a { color:#ff8c00; }</style><body><p><span>In the Christian worldview, a better world did exist.</span></p><p><span>God created a good world and it worked beautifully. All creation was under his leadership and enjoyed him as the source of life.  </span><a href=\"pray://1\">Genesis 1:31</a>&nbsp;&nbsp;</p><p><span><strong>Us and the world: </strong>God designed the world to take care of us and we were designed to flourish in human communities as we cared for the world.  </span><a href=\"pray://2\" >Genesis 1:28</a></p><p><span><strong>Us and each other: </strong>People were designed to love and serve one another.  </span><a href=\"pray://3\">Genesis 1:27</a>, <a href=\"pray://21\">Genesis 2:18</a></p><p><span><strong>Us and God: </strong>We were each designed to live in a trusting and intimate relationship with God as our just and loving leader.  <a href=\"pray://4\">Genesis 1:26</a></span> \
                          <p><strong>The world and all that’s in it was designed for good.</strong></p></body></html>"];
            
            break;
        }
        case 3:
        {
            htmlString = [NSString stringWithFormat:@"<html> \
                          <head> \
                          <title></title> \
                          <style type='text/css'>body { margin:10px; padding:0; } p{margin:10px;} body { color:white; font-family:Trebuchet MS; font-size:14px; } a { color:#ff8c00; }</style> \
                          </head> \
                          <body> \
                          <p>Clearly, the world isn&rsquo;t living according to its design.</span></p> \
                          <p>We rejected God&rsquo;s leadership, took charge, and essentially became our own god. By doing so, we broke our relationship with God, and left ourselves and our world in a state of death.</span> <a href=\"pray://5\" >Isaiah 53:6</a>, <a href=\"pray://22\" >Romans 6:23</a>, <a href=\"pray://23\" >Isaiah 59:2</a>&nbsp; On</span> every level, we have become corrupt. We see evidence of this corruption all around us.</span></p> \
                          <p><strong>Us and the world: </strong>We destructively use the world and the people in it for our own benefit instead of serving them. We see this in sex trafficking, domestic slavery, injustice, oppression, genocide, etc.</span></p> \
                          <p><strong>Us and each other: </strong>We harmfully use people instead of serving them. We see this in conflicts, objectification of people and groups, alienation, bitterness, abuse, lust, anger, etc.</span> <a href=\"pray://6\" >Galatians 5:19-20</a></p> \
                          <p><strong>Us and God: </strong>We damage ourselves and our relationship with God. We refuse to come under his leadership.</span> <a href=\"pray://7\" >Romans 1:21-22</a></p> \
                          <p>We all suffer under these realities. We all contribute to the problem.</span> <a href=\"pray://8\" >Romans 3:23</a></p> \
                          <p>Our corruption compels us toward evil even as we try to do good. Education, technology, and government never get to the root of the problem. The Bible says that God &ldquo;has set a day when the entire human race will be judged and everything set right.&rdquo;</span> <a href=\"pray://9\" >Acts 17:31</a> Not only will he judge the evil people out there, God has seen our own corrupt sides and will hold us accountable.</span></p> \
                          <p><strong>We &ndash; and the world &ndash; are damaged by evil.</strong></span></p> \
                          </html>"];
            
            break;
        }
        case 4:
        {
            htmlString = [NSString stringWithFormat:@"<html> \
                          <head> \
                          <title></title> \
                          <style type='text/css'>body { margin:10px; padding:0; } p{margin:10px;} body { color:white; font-family:Trebuchet MS; font-size:14px; } a { color:#ff8c00; }</style> \
                          </head> \
                          <body> \
                          <p>But God loves the world too much to leave it this way.</span></p> \
                          <p>Because he loves us, God responds to the injustice and corruption. He came as Jesus over 2,000 years ago. <a href=\"pray://10\" >John 3:16</a></p> \
                          <p>By doing that, God started teaching us a better way to live, a way in which all the good things that are supposed to happen actually do.</span></p> \
                          <p>Jesus did three things:</span></p> \
                          <p><strong>Identified: </strong>Jesus became one of us, identifying with us by living in a damaged world (though he never contributed to the damage).</span> <a href=\"pray://11\" >Philippians 2:6-7</a>, <a href=\"pray://24\" >2 Corinthians 5:21</a>&nbsp;&nbsp;</p> \
                          <p><strong>Owned: </strong>Jesus died on the cross, owning the judgment we deserve for the corruption of the world and the corruption in our hearts.</span> <a href=\"pray://12\" >Philippians 2:8</a>, <a href=\"pray://25\" >Romans 3:25-26</a></p> \
                          <p><strong>Overcame: </strong>Jesus rose from the dead, overcoming death, and unleashing power to restore our damaged world.&nbsp;</span></p> \
                          <p><strong>Through Jesus, everything is being restored for better.</strong></span></p> \
                          </body> \
                          </html>"];
            
            break;
        }
        case 5:
        {
            htmlString = [NSString stringWithFormat:@"<html> \
                          <head> \
                          <title></title> \
                          <style type='text/css'>body { margin:10px; padding:0; } p{margin:10px;} body { color:white; font-family:Trebuchet MS; font-size:14px; } a { color:#ff8c00; }</style>  \
                          </head> \
                          <body> \
                          <p>Jesus calls us to follow him as he heals the damage in the world.</span> <a href=\"pray://13\" >Acts 3:6-7</a> By following him, we become the hands and feet of Jesus in the world.</span> <a href=\"pray://14\" >Matthew 5:14-16</a>, <a href=\"pray://26\" >John 20:21-22</a></p> \
                          <p><strong>Us and the world: </strong>Jesus has the power to restore our damaged world. He invites us to follow him together into his world to expose corruption, bring justice, and love joyfully.</span> <a href=\"pray://15\" >Micah 6:8</a>, <a href=\"pray://27\" >Luke 4:18-19</a></p> \
                          <p><strong>Us and each other: </strong>Jesus has the power to restore our relationships. He invites us to follow him by serving, loving, and forgiving each other.</span> <a href=\"pray://16\" >Philippians 2:3-4</a>, <a href=\"pray://28\" >1 John 4:10-11</a></p> \
                          <p><strong>Us and God: </strong>Jesus has the power to restore our relationship with God. He invites us to follow him by coming under his leadership. </span> <a href=\"pray://17\" >Romans 5:10-11</a>, <a href=\"pray://29\" >Mark 1:17</a>, <a href=\"pray://30\" >Mark 2:14</a></p> \
                          <p>We follow him by: </span></p> \
                          <p><strong>Identifying: </strong>We identify with Jesus&rsquo; work by believing his death and resurrection broke the cycle of corruption in us and in the world.</span> <a href=\"pray://18\" >John 3:17-18</a>, <a href=\"pray://31\" >Galatians 2:20-21</a>, <a href=\"pray://32\" >Romans 10:9</a></p> \
                          <p><strong>Owning: </strong>We own our individual responsibility for the damaged world and receive his forgiveness.</span> <a href=\"pray://19\" >1 John 1:9</a>, <a href=\"pray://33\" >Acts 10:43</a></p> \
                          <p><strong>Overcoming: </strong>We overcome the damage in our world by committing to follow Jesus into his mission to the world. God gives us the power to follow Jesus by giving us his Spirit and a community of people who also follow Jesus.</span> <a href=\"pray://20\" >Acts 1:8</a>, <a href=\"pray://34\" >Matthew 5:14-16</a></p> \
                          <p><strong>With Jesus, our mission is to be sent to heal.</strong></span></p> \
                          </body> \
                          </html>"];
            
            break;
        }
        case 6:
        {
            htmlString = [NSString stringWithFormat:@"<html><head><title></title><style type='text/css'>body { margin:10px; padding:0; } p{margin:10px;} body { color:white; font-family:Trebuchet MS; font-size:14px; } a { color:#ff8c00; }</style>  \
                          </head><body><p>But why can&rsquo;t we just jump to the last world in the diagram?</span></p><p>We might like the mission Jesus is talking about, but we want to do it without faith or spirituality.</span></p><p>Even if we could do this&mdash;which we can&rsquo;t&mdash;we&rsquo;d be missing out.</span></p><p>The world&rsquo;s problems are infinite. We are bound to get overwhelmed if we try to take care of it all on our own. Plus, our anger, prejudices, and self-righteousness will compete with our service, limiting the amount of healing we can offer.</span></p><p><strong>We need resources like Christian community and God&rsquo;s presence, the Holy Spirit, which we can get only through Jesus.</strong> </span></p></body></html>"];
            
            break;
        }
        case 7:
        {
            htmlString = [NSString stringWithFormat:@"<html><style type='text/css'>body { margin:10px; padding:0; } p{margin:10px;} body { color:white; font-family:Trebuchet MS; font-size:14px; } a { color:#ff8c00; }</style>  \
                          <body><p><span style=\"color: #ffffff;\"><strong>IF YOU ARE IN WORLD 1, you think the world is fine. But we have seen that it is hard to reconcile this with the suffering in the world. How do you reconcile these things?</strong></span></p></body></html>"];
            
            break;
        }
            
        case 8:
        {
            htmlString = [NSString stringWithFormat:@"<html><style type='text/css'>body { margin:10px; padding:0; } p{margin:10px;} body { color:white; font-family:Trebuchet MS; font-size:14px; } a { color:#ff8c00; }</style>  \
                          <body><p><strong><span style=\"color: #ffffff;\">IF YOU ARE IN WORLD 2, you&rsquo;re overwhelmed by the evil in the world, and even the evil in your own heart. Jesus is calling you to follow him.</span></strong></p><p><strong><span style=\"color: #ffffff;\">Would you like to become a follower of Jesus today?</span></strong></p><p><strong><span style=\"color: #ffffff;\"> You can begin by telling Jesus you would like to become a follower. You can pray using &ldquo;A Prayer Response to Jesus&rdquo; (click the Pray icon below). </span></strong></p></body></html>"];
            
            break;
        }
            
        case 9:
        {
            htmlString = [NSString stringWithFormat:@"<html><style type='text/css'>body { margin:10px; padding:0; } p{margin:10px;} body { color:white; font-family:Trebuchet MS; font-size:14px; } a { color:#ff8c00; }</style>  \
                          <body><p><span style=\"color: #ffffff;\"><strong>IF YOU ARE IN WORLD 3, you have some understanding of what Jesus did and he is calling you to follow him.</strong></span></p><p><span style=\"color: #ffffff;\"><strong>Would you like to become a follower of Jesus and engage in his mission to heal the world with his community and with the help of his Spirit today?</strong></span></p><p><span style=\"color: #ffffff;\"><strong> You can begin by telling Jesus you would like to become a follower. You can pray using &ldquo;A Prayer Response to Jesus&rdquo; (click the Pray icon below).</strong></span></p></body></html>"];
            
            break;
        }
            
        case 10:
        {
            htmlString = [NSString stringWithFormat:@"<html><style type='text/css'>body { margin:10px; padding:0; } p{margin:10px;} body { color:white; font-family:Trebuchet MS; font-size:14px; } a { color:#ff8c00; }</style>  \
                          <body><p><span style=\"color: #ffffff;\"><strong>IF YOU ARE IN WORLD 4, you are doing good in the world. Are you following Jesus and engaging in his mission to heal the world with his community?</strong></span></p><p><span style=\"color: #ffffff;\"><strong>IF YES: Are you involved in Jesus&rsquo; community? Would you like to receive information about fellowship?</strong></span></p><p><span style=\"color: #ffffff;\"><strong>IF NO: Would you like to become a follower of Jesus and engage in his mission to heal the world with his community and with the help of his Spirit today?</strong></span></p><p><span style=\"color: #ffffff;\"><strong> You can begin by telling Jesus you would like to become a follower. You can pray using &ldquo;A Prayer Response to Jesus&rdquo; (click the Pray icon below). </strong></span></p></body></html>"];
            
            break;
        }
            
        default:
            break;
    }
    
    webView.delegate = self;
    [webView loadHTMLString:htmlString baseURL:nil];
    
}




-(BOOL) webView:(UIWebView *)inWeb shouldStartLoadWithRequest:(NSURLRequest *)inRequest navigationType:(UIWebViewNavigationType)inType {
    if ( inType == UIWebViewNavigationTypeLinkClicked ) {
        if([inRequest.URL.scheme compare:@"pray"] == 0) {
            [self pray: inRequest.URL.host.intValue];
            return NO;
        }
        else {
        [[UIApplication sharedApplication] openURL:[inRequest URL]];
        return NO;
        }
    }
    
    return YES;
}

-(void)hideExtraIcons {
    /*
    [menuButton removeFromSuperview];
    [prayButton removeFromSuperview];
    [shareButton removeFromSuperview];
     */
}
-(void)pray:(int)tag {
    
    NSLog(@"Tag: %d",tag);
    
    NSString *title;
    NSString *message;
    switch (tag) {
        case 1:
            title = @"Genesis 1:31";
            message = @"God saw all that he had made, and it was very good. And there was evening, and there was morning—the sixth day.";
            break;
            
        case 2:
            title = @"Genesis 1:28";
            message = @"God blessed them and said to them, \"Be fruitful and increase in number; fill the earth and subdue it. Rule over the fish in the sea and the birds in the sky and over every living creature that moves on the ground.\"";
            break;
        case 3:
            title = @"Genesis 1:27";
            message = @"So God created mankind in his own image, in the image of God he created them; male and female he created them.";
            break;
        case 21:
            title = @"Genesis 2:18";
            message = @"The Lord God said, \"It is not good for the man to be alone. I will make a helper suitable for him.\"";
            break;
        case 4:
            title = @"Genesis 1:26";
            message = @"Then God said, \"Let us make mankind in our image, in our likeness, so that they may rule over the fish in the sea and the birds in the sky, over the livestock and all the wild animals, and over all the creatures that move along the ground.\"";
            break;
        case 5:
            title = @"Isaiah 53:6";
            message = @"We all, like sheep, have gone astray, each of us has turned to our own way; and the Lord has laid on him the iniquity of us all.";
            break;
        case 22:
            title = @"Romans 6:23";
            message = @"For the wages of sin is death, but the gift of God is eternal life in Christ Jesus our Lord.";
            break;
        case 23:
            title = @"Isaiah 59:2";
            message = @"But your iniquities have separated you from your God; your sins have hidden his face from you, so that he will not hear.";
            break;
        case 6:
            title = @"Galatians 5:19-20";
            message = @"The acts of the flesh are obvious: sexual immorality, impurity and debauchery; idolatry and witchcraft; hatred, discord, jealousy, fits of rage, selfish ambition, dissensions, factions.";
            break;
        case 7:
            title = @"Romans 1:21-22";
            message = @"For although they knew God, they neither glorified him as God nor gave thanks to him, but their thinking became futile and their foolish hearts were darkened. Although they claimed to be wise, they became fools.";
            break;
        case 8:
            title = @"Romans 3:23";
            message = @"For all have sinned and fall short of the glory of God.";
            break;
        case 9:
            title = @"Acts 17:31";
            message = @"For he has set a day when he will judge the world with justice by the man he has appointed. He has given proof of this to everyone by raising him from the dead.";
            break;
        case 10:
            title = @"John 3:16";
            message = @"For God so loved the world that he gave his one and only Son, that whoever believes in him shall not perish but have eternal life.";
            break;
        case 11:
            title = @"Philippians 2:6-7";
            message = @"Who, being in very nature God, did not consider equality with God something to be used to his own advantage; rather, he made himself nothing by taking the very nature of a servant, being made in human likeness.";
            break;
        case 24:
            title = @"2 Corinthians 5:21";
            message = @"God made him who had no sin to be sin for us, so that in him we might become the righteousness of God.";
            break;
        case 12:
            title = @"Philippians 2:8";
            message = @"And being found in appearance as a man, he humbled himself by becoming obedient to death—even death on a cross!";
            break;
        case 25:
            title = @"Romans 3:25-26";
            message = @"God presented Christ as a sacrifice of atonement, through the shedding of his blood—to be received by faith. He did this to demonstrate his righteousness, because in his forbearance he had left the sins committed beforehand unpunished—he did it to demonstrate his righteousness at the present time, so as to be just and the one who justifies those who have faith in Jesus.";
            break;
        case 13:
            title = @"Acts 3:6-7";
            message = @"Then Peter said, \"Silver or gold I do not have, but what I do have I give you. In the name of Jesus Christ of Nazareth, walk.\" Taking him by the right hand, he helped him up, and instantly the man’s feet and ankles became strong.";
            break;
        case 14:
            title = @"Matthew 5:14-16";
            message = @"You are the light of the world. A town built on a hill cannot be hidden. Neither do people light a lamp and put it under a bowl. Instead they put it on its stand, and it gives light to everyone in the house. In the same way, let your light shine before others, that they may see your good deeds and glorify your Father in heaven.";
            break;
        case 26:
            title = @"John 20:21-22";
            message = @"Again Jesus said, \"Peace be with you! As the Father has sent me, I am sending you.\" And with that he breathed on them and said, “\"Receive the Holy Spirit.\"";
            break;
        case 15:
            title = @"Micah 6:8";
            message = @"He has shown you, O mortal, what is good. And what does the Lord require of you? To act justly and to love mercy and to walk humbly with your God.";
            break;
        case 27:
            title = @"Luke 4:18-19";
            message = @"\"The Spirit of the Lord is on me, because he has anointed me to proclaim good news to the poor. He has sent me to proclaim freedom for the prisoners and recovery of sight for the blind, to set the oppressed free, to proclaim the year of the Lord’s favor.\"";
            break;
        case 16:
            title = @"Philippians 2:3-4";
            message = @"Do nothing out of selfish ambition or vain conceit. Rather, in humility value others above yourselves, not looking to your own interests but each of you to the interests of the others.";
            break;
        case 28:
            title = @"1 John 4:10-11";
            message = @"This is love: not that we loved God, but that he loved us and sent his Son as an atoning sacrifice for our sins. Dear friends, since God so loved us, we also ought to love one another.";
            break;
        case 17:
            title = @"Romans 5:10-11";
            message = @"For if, while we were God’s enemies, we were reconciled to him through the death of his Son, how much more, having been reconciled, shall we be saved through his life! Not only is this so, but we also boast in God through our Lord Jesus Christ, through whom we have now received reconciliation.";
            break;
        case 29:
            title = @"Mark 1:17";
            message = @"\"Come, follow me,\" Jesus said, \"and I will send you out to fish for people.\"";
            break;
        case 30:
            title = @"Mark 2:14";
            message = @"As he walked along, he saw Levi son of Alphaeus sitting at the tax collector’s booth. \"Follow me,\" Jesus told him, and Levi got up and followed him.";
            break;
        case 18:
            title = @"John 3:17-18";
            message = @"For God did not send his Son into the world to condemn the world, but to save the world through him. Whoever believes in him is not condemned, but whoever does not believe stands condemned already because they have not believed in the name of God’s one and only Son.";
            break;
        case 31:
            title = @"Galatians 2:20-21";
            message = @"I have been crucified with Christ and I no longer live, but Christ lives in me. The life I now live in the body, I live by faith in the Son of God, who loved me and gave himself for me. I do not set aside the grace of God, for if righteousness could be gained through the law, Christ died for nothing!\"";
            break;
        case 32:
            title = @"Romans 10:9";
            message = @"If you declare with your mouth, \"Jesus is Lord,\" and believe in your heart that God raised him from the dead, you will be saved.";
            break;
        case 19:
            title = @"John 1:9";
            message = @"If we confess our sins, he is faithful and just and will forgive us our sins and purify us from all unrighteousness.";
            break;
        case 33:
            title = @"Acts 10:43";
            message = @"All the prophets testify about him that everyone who believes in him receives forgiveness of sins through his name.";
            break;
        case 20:
            title = @"Acts 1:8";
            message = @"But you will receive power when the Holy Spirit comes on you; and you will be my witnesses in Jerusalem, and in all Judea and Samaria, and to the ends of the earth.";
            break;
        case 34:
            title = @"Matthew 5:14-16";
            message = @"You are the light of the world. A town built on a hill cannot be hidden. Neither do people light a lamp and put it under a bowl. Instead they put it on its stand, and it gives light to everyone in the house. In the same way, let your light shine before others, that they may see your good deeds and glorify your Father in heaven.";
            break;
    }


    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title  message:message delegate:self cancelButtonTitle:@"Done"   otherButtonTitles:nil, nil];
    [alertView show];
}

- (IBAction)goBack:(id)sender {
    
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        [delegate backButtonTapped];
        [(TraceViewController *)frontSide flipBackCard:self];
    }
    else
    {
        [delegate backButtonTapped];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (IBAction)share:(id)sender {
    
    if ([MFMailComposeViewController canSendMail]) {
        
        MFMailComposeViewController *mailViewController = [[MFMailComposeViewController alloc] init];
        mailViewController.mailComposeDelegate = self;
        [mailViewController setSubject:@"Recap of our conversation"];
        [mailViewController setMessageBody:@"Thanks for the conversation today. I’ve attached a PDF that recaps what we talked about. \n \n If you ever have questions, please let me know – I’m happy to talk more with you." isHTML:NO];
        NSString *filePath = [[NSBundle mainBundle] pathForResource: @"TheBigStory_recap" ofType: @"pdf"];
        NSData *pdfData = [NSData dataWithContentsOfFile: filePath];
        [mailViewController addAttachmentData: pdfData mimeType:@"application/pdf" fileName:@"TheBigStory_recap.pdf"];
        [self presentModalViewController:mailViewController animated:YES];
        
    }
    
    else {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Cannot Send EMail" message:@"Your device cannot send email. Please set it up. " delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
        [alert show];
        
    }
    
}

-(void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
    // Notifies users about errors associated with the interface
    switch (result) {
            
        case MFMailComposeResultCancelled:
        case MFMailComposeResultSaved:
        case MFMailComposeResultSent:
            [self dismissViewControllerAnimated:YES completion:nil];
            break;
            
        case MFMailComposeResultFailed:
        {
            [self dismissViewControllerAnimated:YES completion:nil];
            UIAlertView *resultAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Mailing failed", nil) message:[error localizedDescription]  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            [resultAlert show];
            break;
        }
    }
    
    

    
    
}


- (IBAction)goToMenu:(id)sender {
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ) {
            [(TraceViewController*)frontSide goToMenu:nil];
        }
    else{
        [delegate gotoMenuButtonTapped];
    }
}


- (IBAction)footerPray:(id)sender {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"A Prayer Response to Jesus"   message:@"Jesus, I believe that your death and resurrection broke the cycle of corruption in the world and in me. I acknowledge my responsibility in contributing to the damage in the world. I receive your forgiveness. I choose to follow you and let you be my leader. I receive your Spirit." delegate:self cancelButtonTitle:@"Done"   otherButtonTitles:nil, nil];
    [alertView show];
}

- (IBAction)startNew:(id)sender {
    [(TraceViewController *)frontSide iPadStartNew:nil];
}

- (void)didReceiveMemoryWarningue

{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)test:(id)sender {
}
- (IBAction)aboutTapped:(id)sender {
    
    AboutViewController *aboutView = [[AboutViewController alloc] initWithNibName:@"AboutView-iPad" bundle:nil];
    aboutView.contentSizeForViewInPopover = CGSizeMake(320, 460);
    UIPopoverController* aPopover = [[UIPopoverController alloc]
                                     initWithContentViewController:aboutView];
    // aPopover.delegate = self;
    
    // Store the popover in a custom property for later use.
    //self.popoverController = aPopover;
    self.popoverController = aPopover;
    [self.popoverController presentPopoverFromRect:CGRectMake(280,1,100,100) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    
    //[aPopover presentPopoverFromBarButtonItem:sender
    //                             permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
    /*
     popup = [[SNPopupView alloc] initWithContentView:aboutView.view contentSize:aboutView.view.bounds.size];
     [popup showAtPoint:CGPointMake(900,20) inView:self.view animated:YES];
     */
    
}

- (IBAction)shareApp:(id)sender {
    
    
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"Share App" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Twitter",@"Facebook", @"Text Message", @"Email", nil];
    sheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ) {
        /* Device is iPad */
        [sheet showFromRect:CGRectMake(150, 1, 100, 100) inView:self.view animated:YES];
    } else {
        /* Device is an iPhone*/
        [sheet showInView:self.view];
    }
    
    
    /*
     // Create the item to share (in this example, a url)
     NSURL *url = [NSURL URLWithString:@"https://itunes.apple.com/us/app/intervarsity-new-world/id586400975?ls=1&mt=8"];
     SHKItem *item = [SHKItem URL:url title:@"InterVarsity -- New World App"];
     
     // Get the ShareKit action sheet
     SHKActionSheet *actionSheet = [SHKActionSheet actionSheetForItem:item];
     
     // Display the action sheet
     [actionSheet showInView:self.view];
     */
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    int buttonInt = buttonIndex;
    
    if (buttonInt == 0) {
        NSURL * url = [NSURL URLWithString:@"https://itunes.apple.com/us/app/intervarsity-new-world/id586400975?ls=1&mt=8"];
        SHKItem *item = [SHKItem URL:url title:@"Share the #gospel with the New World app from #InterVarsity" contentType:SHKURLContentTypeWebpage];
        // Share the item
        [SHKTwitter shareItem:item];
    } if (buttonInt == 1) {
        NSURL * url = [NSURL URLWithString:@"https://itunes.apple.com/us/app/intervarsity-new-world/id586400975?ls=1&mt=8"];
        SHKItem *item = [SHKItem URL:url title:@"I’ve been using InterVarsity Christian Fellowship’s New World app to share the gospel. You can download it for free on your iPhone, iPad, and Android." contentType:SHKURLContentTypeWebpage];
        // Share the item
        [SHKFacebook shareItem:item];
    } if (buttonInt == 2) {
        NSURL * url = [NSURL URLWithString:@"https://itunes.apple.com/us/app/intervarsity-new-world/id586400975?ls=1&mt=8"];
        
        SHKItem *item = [SHKItem URL:url title:@"Share the gospel with InterVarsity’s New World app. Check it out:" contentType:SHKURLContentTypeWebpage];
        item.text = @"Share the gospel with InterVarsity’s New World app. Check it out: https://itunes.apple.com/us/app/intervarsity-new-world/id586400975?ls=1&mt=8";
        [SHKTextMessage shareItem:item];
    } if (buttonInt == 3) {
        NSURL * url = [NSURL URLWithString:@"https://itunes.apple.com/us/app/intervarsity-new-world/id586400975?ls=1&mt=8"];
        SHKItem *item = [SHKItem URL:url title:@"Check out InterVarsity’s New World app" contentType:SHKURLContentTypeWebpage];
        item.text = @"Hey there! \n I’ve been using InterVarsity Christian Fellowship’s New World app and thought you might like it. It’s a tool to help you present the gospel anywhere and anytime right from your smartphone or tablet. https://itunes.apple.com/us/app/intervarsity-new-world/id586400975?ls=1&mt=8 ";
        [SHKMail shareItem:item];
    }
}

@end