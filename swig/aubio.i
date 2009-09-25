%module aubiowrapper

%{
        #include "aubio.h"
        #include "aubioext.h"
%}

#include "aubio.h"
#include "aubioext.h"

/* type aliases */
typedef unsigned int uint_t;
typedef int sint_t;
typedef float smpl_t;

/* fvec */
extern fvec_t * new_fvec(uint_t length, uint_t channels);
extern void del_fvec(fvec_t *s);
smpl_t fvec_read_sample(fvec_t *s, uint_t channel, uint_t position);
void fvec_write_sample(fvec_t *s, smpl_t data, uint_t channel, uint_t position);
smpl_t * fvec_get_channel(fvec_t *s, uint_t channel);
void fvec_put_channel(fvec_t *s, smpl_t * data, uint_t channel);
smpl_t ** fvec_get_data(fvec_t *s);

/* another way, passing -c++ option to swig */
/*
class fvec_t{
public:
    %extend {
        fvec_t(uint_t length, uint_t channels){
            return new_fvec(length, channels);
        }
        ~fvec_t() {
            del_fvec(self);
        }
        smpl_t get( uint_t channel, uint_t position) {
            return fvec_read_sample(self,channel,position);
        }
        void set( smpl_t data, uint_t channel, uint_t position) {
            fvec_write_sample(self, data, channel, position); 
        }
        #smpl_t * fvec_get_channel(fvec_t *s, uint_t channel);
        #void fvec_put_channel(fvec_t *s, smpl_t * data, uint_t channel);
    }
};
*/

/* cvec */
extern cvec_t * new_cvec(uint_t length, uint_t channels);
extern void del_cvec(cvec_t *s);
extern void cvec_write_norm(cvec_t *s, smpl_t data, uint_t channel, uint_t position);
extern void cvec_write_phas(cvec_t *s, smpl_t data, uint_t channel, uint_t position);
extern smpl_t cvec_read_norm(cvec_t *s, uint_t channel, uint_t position);
extern smpl_t cvec_read_phas(cvec_t *s, uint_t channel, uint_t position);
extern void cvec_put_norm_channel(cvec_t *s, smpl_t * data, uint_t channel);
extern void cvec_put_phas_channel(cvec_t *s, smpl_t * data, uint_t channel);
extern smpl_t * cvec_get_norm_channel(cvec_t *s, uint_t channel);
extern smpl_t * cvec_get_phas_channel(cvec_t *s, uint_t channel);
extern smpl_t ** cvec_get_norm(cvec_t *s);
extern smpl_t ** cvec_get_phas(cvec_t *s);


/* sndfile */
extern aubio_sndfile_t * new_aubio_sndfile_ro (const char * inputfile);
extern aubio_sndfile_t * new_aubio_sndfile_wo(aubio_sndfile_t * existingfile, const char * outputname);
extern void aubio_sndfile_info(aubio_sndfile_t * file);
extern int aubio_sndfile_write(aubio_sndfile_t * file, int frames, fvec_t * write);
extern int aubio_sndfile_read(aubio_sndfile_t * file, int frames, fvec_t * read);
extern int del_aubio_sndfile(aubio_sndfile_t * file);
extern uint_t aubio_sndfile_channels(aubio_sndfile_t * file);
extern uint_t aubio_sndfile_samplerate(aubio_sndfile_t * file);

/* fft */
extern aubio_fft_t * new_aubio_fft(uint_t size, uint_t channels);
extern void del_aubio_fft(aubio_fft_t * s);
extern void aubio_fft_do (aubio_fft_t *s, fvec_t * input, cvec_t * spectrum);
extern void aubio_fft_rdo (aubio_fft_t *s, cvec_t * spectrum, fvec_t * output);
extern void aubio_fft_do_complex (aubio_fft_t *s, fvec_t * input, fvec_t * compspec);
extern void aubio_fft_rdo_complex (aubio_fft_t *s, fvec_t * compspec, fvec_t * output);
extern void aubio_fft_get_spectrum(fvec_t * compspec, cvec_t * spectrum);
extern void aubio_fft_get_realimag(cvec_t * spectrum, fvec_t * compspec);
extern void aubio_fft_get_phas(fvec_t * compspec, cvec_t * spectrum);
extern void aubio_fft_get_imag(cvec_t * spectrum, fvec_t * compspec);
extern void aubio_fft_get_norm(fvec_t * compspec, cvec_t * spectrum);
extern void aubio_fft_get_real(cvec_t * spectrum, fvec_t * compspec);

/* filter */
extern aubio_filter_t * new_aubio_filter(uint_t samplerate, uint_t order, uint_t channels);
extern void aubio_filter_do(aubio_filter_t * b, fvec_t * in);
extern void aubio_filter_do_outplace(aubio_filter_t * b, fvec_t * in, fvec_t * out);
extern void aubio_filter_do_filtfilt(aubio_filter_t * b, fvec_t * in, fvec_t * tmp);
extern void del_aubio_filter(aubio_filter_t * b);

extern aubio_filter_t * new_aubio_adsgn_filter(uint_t samplerate, uint_t channels);
extern void aubio_adsgn_filter_do(aubio_filter_t * b, fvec_t * in);
extern void del_aubio_adsgn_filter(aubio_filter_t * b);

extern aubio_filter_t * new_aubio_cdsgn_filter(uint_t samplerate, uint_t channels);
extern void aubio_cdsgn_filter_do(aubio_filter_t * b, fvec_t * in);
extern void del_aubio_cdsgn_filter(aubio_filter_t * b);

/* biquad */
extern aubio_biquad_t * new_aubio_biquad(lsmp_t b1, lsmp_t b2, lsmp_t b3, lsmp_t a2, lsmp_t a3);
extern void aubio_biquad_do(aubio_biquad_t * b, fvec_t * in);
extern void aubio_biquad_do_filtfilt(aubio_biquad_t * b, fvec_t * in, fvec_t * tmp);
extern void del_aubio_biquad(aubio_biquad_t * b);

/* hist */
extern aubio_hist_t * new_aubio_hist(smpl_t flow, smpl_t fhig, uint_t nelems, uint_t channels);
extern void del_aubio_hist(aubio_hist_t *s);
extern void aubio_hist_do(aubio_hist_t *s, fvec_t * input);
extern void aubio_hist_do_notnull(aubio_hist_t *s, fvec_t * input);
extern void aubio_hist_dyn_notnull(aubio_hist_t *s, fvec_t *input);
extern void aubio_hist_weight(aubio_hist_t *s);
extern smpl_t aubio_hist_mean(aubio_hist_t *s);

/* mathutils */
typedef enum {
        aubio_win_rectangle,
        aubio_win_hamming,
        aubio_win_hanning,
        aubio_win_hanningz,
        aubio_win_blackman,
        aubio_win_blackman_harris,
        aubio_win_gaussian,
        aubio_win_welch,
        aubio_win_parzen
} aubio_window_type;

fvec_t * new_aubio_window(uint_t size, aubio_window_type wintype);
smpl_t aubio_unwrap2pi (smpl_t phase);
smpl_t vec_mean(fvec_t *s);
smpl_t vec_max(fvec_t *s);
smpl_t vec_min(fvec_t *s);
uint_t vec_min_elem(fvec_t *s);
uint_t vec_max_elem(fvec_t *s);
void vec_shift(fvec_t *s);
smpl_t vec_sum(fvec_t *s);
smpl_t vec_local_energy(fvec_t * f);
smpl_t vec_local_hfc(fvec_t * f);
smpl_t vec_alpha_norm(fvec_t * DF, smpl_t alpha);
void vec_dc_removal(fvec_t * mag);
void vec_alpha_normalise(fvec_t * mag, uint_t alpha);
void vec_add(fvec_t * mag, smpl_t threshold);
void vec_adapt_thres(fvec_t * vec, fvec_t * tmp, uint_t post, uint_t pre);
smpl_t vec_moving_thres(fvec_t * vec, fvec_t * tmp, uint_t post, uint_t pre, uint_t pos);
smpl_t vec_median(fvec_t * input);
smpl_t vec_quadint(fvec_t * x,uint_t pos, uint_t span);
smpl_t aubio_quadfrac(smpl_t s0, smpl_t s1, smpl_t s2, smpl_t pf);
uint_t vec_peakpick(fvec_t * input, uint_t pos);
smpl_t aubio_bintomidi(smpl_t bin, smpl_t samplerate, smpl_t fftsize);
smpl_t aubio_miditobin(smpl_t midi, smpl_t samplerate, smpl_t fftsize);
smpl_t aubio_bintofreq(smpl_t bin, smpl_t samplerate, smpl_t fftsize);
smpl_t aubio_freqtobin(smpl_t freq, smpl_t samplerate, smpl_t fftsize);
smpl_t aubio_freqtomidi(smpl_t freq);
smpl_t aubio_miditofreq(smpl_t midi);
uint_t aubio_silence_detection(fvec_t * ibuf, smpl_t threshold);
smpl_t aubio_level_detection(fvec_t * ibuf, smpl_t threshold);
void aubio_autocorr(fvec_t * in, fvec_t * acf);
smpl_t aubio_zero_crossing_rate(fvec_t * input);
smpl_t aubio_spectral_centroid(cvec_t * spectrum, smpl_t samplerate);

/* filterbank */
aubio_filterbank_t * new_aubio_filterbank(uint_t win_s, uint_t channels);
void aubio_filterbank_set_mel_coeffs(aubio_filterbank_t *fb, fvec_t *freqs, uint_t samplerate);
void aubio_filterbank_set_mel_coeffs_slaney(aubio_filterbank_t *fb, uint_t samplerate);
void del_aubio_filterbank(aubio_filterbank_t * fb);
void aubio_filterbank_do(aubio_filterbank_t * fb, cvec_t * in, fvec_t *out);
fvec_t * aubio_filterbank_get_coeffs(aubio_filterbank_t * fb);

/* mfcc */
aubio_mfcc_t * new_aubio_mfcc (uint_t win_s, uint_t samplerate, uint_t n_filters, uint_t n_coefs);
void del_aubio_mfcc(aubio_mfcc_t *mf);
void aubio_mfcc_do(aubio_mfcc_t *mf, cvec_t *in, fvec_t *out);

/* scale */
extern aubio_scale_t * new_aubio_scale(smpl_t flow, smpl_t fhig, smpl_t ilow, smpl_t ihig);
extern void aubio_scale_set (aubio_scale_t *s, smpl_t ilow, smpl_t ihig, smpl_t olow, smpl_t ohig);
extern void aubio_scale_do(aubio_scale_t *s, fvec_t * input);
extern void del_aubio_scale(aubio_scale_t *s);

/* resampling */
extern aubio_resampler_t * new_aubio_resampler(float ratio, uint_t type);
extern uint_t aubio_resampler_process(aubio_resampler_t *s, fvec_t * input,  fvec_t * output);
extern void del_aubio_resampler(aubio_resampler_t *s);

/* onset detection */
typedef enum { 
        aubio_onset_energy, 
        aubio_onset_specdiff, 
        aubio_onset_hfc, 
        aubio_onset_complex, 
        aubio_onset_phase, 
        aubio_onset_kl, 
        aubio_onset_mkl, 
        aubio_onset_specflux,
} aubio_onsetdetection_type;
aubio_onsetdetection_t * new_aubio_onsetdetection(aubio_onsetdetection_type type, uint_t size, uint_t channels);
void aubio_onsetdetection(aubio_onsetdetection_t *o, cvec_t * fftgrain, fvec_t * onset);
void del_aubio_onsetdetection(aubio_onsetdetection_t *o);

/* should these still be exposed ? */
void aubio_onsetdetection_energy  (aubio_onsetdetection_t *o, cvec_t * fftgrain, fvec_t * onset);
void aubio_onsetdetection_hfc     (aubio_onsetdetection_t *o, cvec_t * fftgrain, fvec_t * onset);
void aubio_onsetdetection_complex (aubio_onsetdetection_t *o, cvec_t * fftgrain, fvec_t * onset);
void aubio_onsetdetection_phase   (aubio_onsetdetection_t *o, cvec_t * fftgrain, fvec_t * onset);
void aubio_onsetdetection_specdiff(aubio_onsetdetection_t *o, cvec_t * fftgrain, fvec_t * onset);
void aubio_onsetdetection_kl      (aubio_onsetdetection_t *o, cvec_t * fftgrain, fvec_t * onset);
void aubio_onsetdetection_mkl     (aubio_onsetdetection_t *o, cvec_t * fftgrain, fvec_t * onset);

/* pvoc */
aubio_pvoc_t * new_aubio_pvoc (uint_t win_s, uint_t hop_s, uint_t channels);
void del_aubio_pvoc(aubio_pvoc_t *pv);
void aubio_pvoc_do(aubio_pvoc_t *pv, fvec_t *in, cvec_t * fftgrain);
void aubio_pvoc_rdo(aubio_pvoc_t *pv, cvec_t * fftgrain, fvec_t *out);

/* pitch detection */
typedef enum {
        aubio_pitch_yin,
        aubio_pitch_mcomb,
        aubio_pitch_schmitt,
        aubio_pitch_fcomb,
        aubio_pitch_yinfft
} aubio_pitchdetection_type;

typedef enum {
        aubio_pitchm_freq,
        aubio_pitchm_midi,
        aubio_pitchm_cent,
        aubio_pitchm_bin
} aubio_pitchdetection_mode;

smpl_t aubio_pitchdetection(aubio_pitchdetection_t * p, fvec_t * ibuf);

void aubio_pitchdetection_set_yinthresh(aubio_pitchdetection_t *p, smpl_t thres);

void del_aubio_pitchdetection(aubio_pitchdetection_t * p);

aubio_pitchdetection_t * new_aubio_pitchdetection(uint_t bufsize, 
    uint_t hopsize, 
    uint_t channels,
    uint_t samplerate,
    aubio_pitchdetection_type type,
    aubio_pitchdetection_mode mode);


/* pitch mcomb */
aubio_pitchmcomb_t * new_aubio_pitchmcomb(uint_t bufsize, uint_t hopsize, uint_t channels, uint_t samplerate);
smpl_t aubio_pitchmcomb_detect(aubio_pitchmcomb_t * p, cvec_t * fftgrain);
uint_t aubio_pitch_cands(aubio_pitchmcomb_t * p, cvec_t * fftgrain, smpl_t * cands);
void del_aubio_pitchmcomb (aubio_pitchmcomb_t *p);

/* pitch yin */
void aubio_pitchyin_diff(fvec_t *input, fvec_t *yin);
void aubio_pitchyin_getcum(fvec_t *yin);
uint_t aubio_pitchyin_getpitch(fvec_t *yin);
smpl_t aubio_pitchyin_getpitchfast(fvec_t * input, fvec_t *yin, smpl_t tol);

/* pitch schmitt */
aubio_pitchschmitt_t * new_aubio_pitchschmitt (uint_t size, uint_t samplerate);
smpl_t aubio_pitchschmitt_detect (aubio_pitchschmitt_t *p, fvec_t * input);
void del_aubio_pitchschmitt (aubio_pitchschmitt_t *p);

/* pitch fcomb */
aubio_pitchfcomb_t * new_aubio_pitchfcomb (uint_t size, uint_t hopsize, uint_t samplerate);
smpl_t aubio_pitchfcomb_detect (aubio_pitchfcomb_t *p, fvec_t * input);
void del_aubio_pitchfcomb (aubio_pitchfcomb_t *p);

/* peakpicker */
aubio_pickpeak_t * new_aubio_peakpicker(smpl_t threshold);
uint_t aubio_peakpick_pimrt(fvec_t * DF, aubio_pickpeak_t * p);
uint_t aubio_peakpick_pimrt_wt( fvec_t* DF, aubio_pickpeak_t* p, smpl_t* peakval );
smpl_t aubio_peakpick_pimrt_getval(aubio_pickpeak_t* p);
void del_aubio_peakpicker(aubio_pickpeak_t * p);
void aubio_peakpicker_set_threshold(aubio_pickpeak_t * p, smpl_t threshold);
smpl_t aubio_peakpicker_get_threshold(aubio_pickpeak_t * p);

/* transient/steady state separation */
aubio_tss_t * new_aubio_tss(smpl_t thrs, smpl_t alfa, smpl_t beta,
    uint_t size, uint_t overlap,uint_t channels);
void del_aubio_tss(aubio_tss_t *s);
void aubio_tss_do(aubio_tss_t *s, cvec_t * input, cvec_t * trans, cvec_t * stead);

/* beattracking */
aubio_beattracking_t * new_aubio_beattracking(uint_t winlen, uint_t channels);
void aubio_beattracking_do(aubio_beattracking_t * bt, fvec_t * dfframes, fvec_t * out);
void del_aubio_beattracking(aubio_beattracking_t * p);
smpl_t aubio_beattracking_get_bpm(aubio_beattracking_t * p);
smpl_t aubio_beattracking_get_confidence(aubio_beattracking_t * p);

