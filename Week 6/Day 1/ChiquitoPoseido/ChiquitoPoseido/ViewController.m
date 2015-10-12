//
//  ViewController.m
//  ChiquitoPoseido
//
//  Created by Toni on 12/10/15.
//  Copyright © 2015 Toni. All rights reserved.
//

#import "ViewController.h"

#import <MobileCoreServices/MobileCoreServices.h>
#import <AudioToolBox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreMotion/CoreMotion.h>

#import "SoundEffect.h"

@interface ViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate, SoundEffectDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic) BOOL newImage;
@property (nonatomic) BOOL onOff;
@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) CMMotionManager *motionManager;
@property (weak, nonatomic) IBOutlet UILabel *gyroLabel;
@property (nonatomic, strong) SoundEffect *soundPlayer;
@property (nonatomic) BOOL canPlayNextSound;
@property (weak, nonatomic) IBOutlet UIProgressView *batteryLevel;
@property (weak, nonatomic) IBOutlet UIProgressView *xProgress;
@property (weak, nonatomic) IBOutlet UIProgressView *yProgress;
@property (weak, nonatomic) IBOutlet UIProgressView *zProgress;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        NSLog(@"📷");
    } else {
        NSLog(@"😱");
    }
    
    [self showBatteryLevel];
    
    [self setupProximity];
    
    self.canPlayNextSound = YES;
    
    self.soundPlayer = [[SoundEffect alloc] init];
    self.soundPlayer.delegate = self;
    
    self.motionManager = [[CMMotionManager alloc] init];
    
    if (self.motionManager.accelerometerAvailable) {
        
        self.motionManager.accelerometerUpdateInterval = .2;
        self.motionManager.gyroUpdateInterval = .2;
        
        __weak typeof(self) weakSelf = self;
        
        [self.motionManager
         startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue]
         withHandler:^(CMAccelerometerData *accelerometerData, NSError *error){
             
             weakSelf.gyroLabel.text = [NSString stringWithFormat:@"x:%.4g y:%.4g z:%.4g",accelerometerData.acceleration.x, accelerometerData.acceleration.y, accelerometerData.acceleration.z];
             weakSelf.xProgress.progress = (accelerometerData.acceleration.x + 1) / 2;
             weakSelf.yProgress.progress = (accelerometerData.acceleration.y + 1) / 2;
             weakSelf.zProgress.progress = (accelerometerData.acceleration.z + 1) /2;
             
             if (accelerometerData.acceleration.x > 0.95 && weakSelf.canPlayNextSound) {
                 weakSelf.canPlayNextSound = NO;
                 [weakSelf.soundPlayer play:@"notdroid"];
                 
             }
             if(accelerometerData.acceleration.z > 0.95 && weakSelf.canPlayNextSound) {
                 weakSelf.canPlayNextSound = NO;
                 [weakSelf.soundPlayer play:@"saber"];
             }
             if (accelerometerData.acceleration.y > 0.95 && weakSelf.canPlayNextSound) {
                 weakSelf.canPlayNextSound = NO;
                 [weakSelf.soundPlayer play:@"force"];
             }
         }];
    }
}

- (void)setupProgressViews {
    
}

- (void)setupProximity {
    [[UIDevice currentDevice] setProximityMonitoringEnabled:YES];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(proximityStateChanged) name:UIDeviceProximityStateDidChangeNotification object:nil];
}

- (void)proximityStateChanged {
    if ([UIDevice currentDevice].proximityState) {
        [self.soundPlayer play:@"notdroid"];
    }
    
}

- (void)showBatteryLevel {
    [UIDevice currentDevice].batteryMonitoringEnabled = YES;
    float batteryLevel = [UIDevice currentDevice].batteryLevel;
    if (batteryLevel < 0.0) {
        self.batteryLevel.hidden = YES;
    }
    else {
        [self.batteryLevel setProgress:batteryLevel];
    }
}

- (void)soundEffectDidFinishPlaying:(SoundEffect *)soundEffect {
    self.canPlayNextSound = YES;
}


- (IBAction)partyButtonPressed:(id)sender {
    static BOOL isOn = NO;
    
    if (isOn) {
        [self.timer invalidate];
        self.timer = nil;
    } else {
        self.onOff = YES;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(flashLight) userInfo:nil repeats:YES];
    }
    
    isOn = !isOn;
}

- (void)flashLight {
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    [device lockForConfiguration:nil];
    [device setTorchMode: self.onOff ? AVCaptureTorchModeOn : AVCaptureTorchModeOff];
    [device unlockForConfiguration];
    
    self.onOff = !self.onOff;
}

- (void)dealloc {
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    [device lockForConfiguration:nil];
    [device setTorchMode:AVCaptureTorchModeOff];
    [device unlockForConfiguration];
    
}

- (IBAction)cameraButtonPressed:(id)sender {
    [self useCamera:sender];
}


- (void)useCamera:(id)sender {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.mediaTypes = @[(NSString *) kUTTypeImage];
        imagePicker.allowsEditing = NO;
        [self presentViewController:imagePicker animated:YES completion:nil];
        
        self.newImage = YES;
    }
}
- (IBAction)rollButtonPressed:(id)sender {
    [self useCameraRoll:sender];
}

- (void)useCameraRoll:(id)sender {
     if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
         UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
         imagePicker.delegate = self;
         imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
         imagePicker.mediaTypes = @[(NSString *) kUTTypeImage];
         imagePicker.allowsEditing = NO;
         [self presentViewController:imagePicker animated:YES completion:nil];
         
         self.newImage = NO;
     }
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

#pragma mark - UIImagePickerControllerDelegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    NSString *mediaType = info[UIImagePickerControllerMediaType];
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        UIImage *image = info[UIImagePickerControllerOriginalImage];
        
        self.imageView.image = image;
        
        if (self.newImage) {
            UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:finishedSavingWithError:contextInfo:), nil);
            self.newImage = NO;
        }
        
        
    }
}


- (void)image:(UIImage *)image finishedSavingWithError:(NSError *)error contextInfo:(NSDictionary *)contextInfo {
    
}

#pragma mark - Motion

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (motion == UIEventSubtypeMotionShake) {
        [self downloadImageFromURL:@"http://static.comicvine.com/uploads/original/11111/111116692/3215643-1167031751-chewb.png"];
    }
}

#pragma mark - Networking

- (void)downloadImageFromURL:(NSString *)urlString {
    dispatch_queue_t download_q;
    
    download_q = dispatch_queue_create("com.ironhack.donwload", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(download_q, ^{
        NSURL *imageURL = [NSURL URLWithString:urlString];
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageView.image = [UIImage imageWithData:imageData];
             AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        });
    });
}

@end
